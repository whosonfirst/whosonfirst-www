(function(f){

        if (typeof exports === "object" && typeof module !== "undefined"){
		module.exports = f();
        }

        else if (typeof define === "function" && define.amd){
		define([],f);
        }

        else {
		var g;

		if (typeof window!=="undefined") {
			g=window;
		} else if (typeof global!=="undefined") {
			g=global;
		} else if (typeof self!=="undefined") {
			g=self;
		} else {
			g=this;
		}

		g.mapzen = g.mapzen || {};
		g.mapzen.whosonfirst = g.mapzen.whosonfirst || {};
		g.mapzen.whosonfirst.api = g.mapzen.whosonfirst.api = f();
        }

}(function(){

	var null_handler = function(){
		return undefined;
	};

	var mapzen_endpoint = function(){
		return "https://places.mapzen.com/v1"
	};

	var mapzen_authentication = function(){
		return undefined;
	};

	var self = {

		'_handlers': {
			'endpoint': mapzen_endpoint,
			'authentication': null_handler,
		},

		'set_handler': function(target, handler){

			if (! self._handlers[target]){
				console.log("MISSING " + target);
				return false;
			}

			if (typeof(handler) != "function"){
				console.log(target + " IS NOT A FUNCTION");
				return false;
			}

			self._handlers[target] = handler;
		},

		'get_handler': function(target){

			if (! self._handlers[target]){
				return false;
			}

			return self._handlers[target];
		},

		'method': function(name, args){

			if (! args){
				args = {"verb": "GET"};
			}

			var m = function(n, v){

				var self = {
					'name': function(){ return n; },
					'verb': function(){ return v; },
				};

				return self;
			};

			return m(name, args["verb"]);
		},

		'execute_method': function(method, data, on_success, on_error){

			if (typeof(method) == "string"){
				method = self.method(method);
			}

			var dothis_onsuccess = function(rsp){

				if (on_success){
					on_success(rsp);
				}
			};

			var dothis_onerror = function(rsp){

				if (on_error){
					on_error(rsp);
				}
			};

			var get_endpoint = self.get_handler('endpoint');

			if (! get_endpoint){
				dothis_onerror(self.destruct("Missing endpoint handler"));
				return false
			}

			endpoint = get_endpoint();

			if (! endpoint){
				dothis_onerror(self.destruct("Endpoint handler returns no endpoint!"));
				return false
			}

			var form_data = data;

			if (! form_data.append){

				form_data = new FormData();

				for (key in data){
					form_data.append(key, data[key]);
				}
			}

			form_data.append('method', method.name());

			// sudo make this a generic apply_authentication thingy

			if (! form_data.get("api_key")){

				var get_authentication = self.get_handler('authentication');

				if (! get_authentication){
					dothis_onerror(self.destruct("there is no authentication handler"));
					return false;
				}

				form_data.append('api_key', get_authentication());
			}

			var onload = function(rsp){

				var target = rsp.target;

				if (target.readyState != 4){
					return;
				}

				var status_code = target['status'];
				var status_text = target['statusText'];

				var raw = target['responseText'];
				var data = undefined;

				var fmt = form_data.get("format");

				if ((fmt == "json") || (fmt == "geojson") || (fmt == null)){

					try {
						data = JSON.parse(raw);
					}

					catch (e){
						dothis_onerror(self.destruct("failed to parse JSON " + e));
						return false;
					}

					if (data['stat'] != 'ok'){
						dothis_onerror(data);
						return false;
					}
				}

				else {
					data = raw;
				}

				dothis_onsuccess(data);
				return true;
			};

			var onprogress = function(rsp){
			};

			var onfailed = function(rsp){
				dothis_onerror(self.destruct("connection failed " + rsp));
			};

			var onabort = function(rsp){
				dothis_onerror(self.destruct("connection aborted " + rsp));
			};

			// https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Sending_and_Receiving_Binary_Data

			try {
				var req = new XMLHttpRequest();

				req.addEventListener("load", onload);
				req.addEventListener("progress", onprogress);
				req.addEventListener("error", onfailed);
				req.addEventListener("abort", onabort);

				// please fix me...
				// https://github.com/whosonfirst/electron-whosonfirst-api-explorer/issues/11

				if (method.verb() == "GET"){

					if (form_data.keys()){

						var query = [];

						for (var pair of form_data.entries()) {
							query.push(pair[0] + "=" + encodeURIComponent(pair[1]));
						}

						var query_string = query.join("&");
						var sep = (endpoint.indexOf('?') == -1) ? '?' : '&';

						endpoint = endpoint + sep + query.join("&");
					}

					req.open("GET", endpoint, true);
					req.send();

					return;
				}

				req.open("POST", endpoint, true);
				req.send(form_data);

			} catch (e) {

				dothis_onerror(self.destruct("failed to send request, because " + e));
				return false;
			}

			return false;
		},

		'execute_method_paginated': function(method, data, on_success, on_error, on_page){

			var results = [];

			var dothis_onsuccess = function(rsp) {

				results.push(rsp);

				// Added a callback to show each page of results
				// (20170614/dphiffer)
				if (on_page) {
					on_page(rsp);
				}

				if (rsp.next_query) {
					var args = rsp.next_query.split('&');
					for (var i = 0; i < args.length; i++) {
						var arg = args[i].split('=');
						var key = decodeURIComponent(arg[0]);
						var value = decodeURIComponent(arg[1]);
						data[key] = value;
					}
					self.execute_method(method, data, dothis_onsuccess, on_error);
				}  else {
					on_success(results);
				}
			};

			self.execute_method(method, data, dothis_onsuccess, on_error);
		},

		'destruct': function(msg){

			return {
				'stat': 'error',
				'error': {
					'code': 999,
					'message': msg
				}
			};

		},
	}

	return self;
}));
