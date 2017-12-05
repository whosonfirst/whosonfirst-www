/**************************
 * Tangram Legend Control
 * Adds a legend and layer toggle to Tangram maps
 * 
 * (Current) Requirements:  
 *   - Tangram must be loaded and have a valid scene (with config)
 *   - Must pass layers in as an object:
 *      layers: {
 *        "Layer name": 'layer_name'
 *      }
 *
 * ToDo:
 *   - Check for color under layer definition (rather than global)
 *   - Check for "legend" tag in scene file instead of requiring layers object
 *   
 * *************************/

var TangramLegendControl = L.Control.extend({
  options: {
    position: 'bottomleft',
    scene: null,
    legendTitle: null
  },

  initialize: function (layers, options) {
    L.Util.setOptions(this, options);

    if (this.options.scene) {
      this._scene = this.options.scene;
    }

    // Set list of layers
    // TODO: add option to check for legend tag in scene file
    this._layers = [];

    for (i in layers) {
      this._layers.push({
        layer: layers[i],
        name: i
      });
    }
  },

  onAdd: function (map) {
    // If valid scene wasn't passed in as option, check if Tangram is loaded and has valid scene
    if (!this._scene || typeof this._scene !== 'object') {
      var tangramLayer = map.getTangramLayer();

      if (tangramLayer) {
        this._scene = tangramLayer.scene;
      }
      else {
        // Set _scene once Tangram is available
        this._map.on('tangramloaded', function(e) {
          this._scene = e.tangramLayer.scene;
        }, this);        
      }
    }

    var container = this._buildLegend();
    return container;
  },

  _buildLegend: function () {
    var className = 'tangram-legend-control',
        container = L.DomUtil.create('div', className);

    L.DomEvent.disableClickPropagation(container);
    if (!L.Browser.touch) {
      L.DomEvent.disableScrollPropagation(container);
    }

    // Add legend title
    if (this.options.title) {
      var legendTitle = L.DomUtil.create('h3', 'legend-title');
      legendTitle.textContent = this.options.title;
      container.appendChild(legendTitle);
    }

    // Add form/list of layers + symbols
    var form = this._form = L.DomUtil.create('form', className + '-list');

    this._legendLayersList = L.DomUtil.create('div', className + '-layers', form);
    for (var item in this._layers){
      var legendItem = this._buildLegendItem(this._layers[item]);
      this._legendLayersList.appendChild(legendItem);
    }
    container.appendChild(form);

    // Add toggleAll links
    var toggleAllDiv = this._buildToggleAllLinks();
    container.appendChild(toggleAllDiv);

    // Add footer?

    return container;
  },

  /* Takes obj: { name: '', layer: '' } */
  _buildLegendItem: function (obj) {
    var legendItem = L.DomUtil.create('div', 'tangram-legend-item');
    legendItem.id = 'legend-item-' + obj.layer;
    
    var label = document.createElement('label'),
        input = document.createElement('input');

    var checkboxId = 'legend-checkbox-' + obj.layer,
        checked = true; //this._map.hasLayer(obj.layer), // check if visible/enabled

    // Label
    label.htmlFor = checkboxId;

    // Checkbox
    input.type = 'checkbox';
    input.id = checkboxId;
    input.value = obj.layer;
    input.defaultChecked = checked;
    L.DomEvent.on(input, 'click', this._onCheckboxClick, this);

    // Layer name
    var layerName = document.createElement('span');
    layerName.innerHTML = obj.name;

    label.appendChild(input);
    label.appendChild(layerName);

    // Legend symbol
    // TODO: decouple this from scene.config.global
    var colorValue = this.convertRGB(this._scene.config.global[obj.layer].color.slice());
    var symbol = L.DomUtil.create('div', 'circle');
    symbol.style.backgroundColor = 'rgba(' + colorValue + ')';

    // Put it all together
    legendItem.appendChild(symbol);
    legendItem.appendChild(label);

    return legendItem;
  },

  _buildToggleAllLinks: function () {
    var toggleAllDiv = L.DomUtil.create('div', 'toggle-all');

    // Show All link
    var showAllLink = L.DomUtil.create('a', 'show-all');
    showAllLink.textContent = 'Show all';
    showAllLink.href = '#';
    L.DomEvent.on(showAllLink, 'click', this._showAllLayers, this);
    toggleAllDiv.appendChild(showAllLink);

    // Separator "|"
    var separator = L.DomUtil.create('span', 'separator');
    separator.textContent = ' | ';
    toggleAllDiv.appendChild(separator);

    // Hide All link
    var hideAllLink = L.DomUtil.create('a', 'hide-all');
    hideAllLink.textContent = 'Hide all';
    hideAllLink.href = '#';
    L.DomEvent.on(hideAllLink, 'click', this._hideAllLayers, this);
    toggleAllDiv.appendChild(hideAllLink);

    return toggleAllDiv;
  },

  _onCheckboxClick: function (e) {
    var checkbox = e.currentTarget,
        layer = checkbox.value,
        visible = checkbox.checked;

    this._toggleLayer(layer, visible);
    this._scene.updateConfig();
  },

  _showAllLayers: function (e) {
    L.DomEvent.preventDefault(e);
    for (var item in this._layers){
      var layer = this._layers[item].layer;
      this._toggleLayer(layer, true);
    }
    this._scene.updateConfig();
  },

  _hideAllLayers: function (e) {
    L.DomEvent.preventDefault(e);
    for (var item in this._layers){
      var layer = this._layers[item].layer;
      this._toggleLayer(layer, false);
    }
    this._scene.updateConfig();
  },

  _toggleLayer: function (layer, visible) {
    // toggle checkbox
    document.getElementById('legend-checkbox-' + layer).checked = visible;

    // toggle "inactive" className on legend item parent
    document.getElementById('legend-item-' + layer).classList.toggle('inactive', !visible);

    // toggle layer visibility
    scene.config.layers._venues[layer].visible = visible;
  },

  // Used for testing only
  _getListOfAvailableLayers: function () {
    var layersObj = this._scene.config.layers;

    return Object.keys(layersObj);
  },

  convertRGB: function (color) {
    color[0] = Math.floor(color[0]*255);
    color[1] = Math.floor(color[1]*255);
    color[2] = Math.floor(color[2]*255);
    color[3] = 0.75;
    return color;
  }

});


// @factory L.control.layers(layers?: Object, options?: Control.Layers options)
L.control.tangramLegendControl = function (layers, options) {
  return new TangramLegendControl(layers, options);
};