# Adding a New Page

To add a new page, follow the instructions below:

1. Determine if the page, belongs in an existing folder. Currently there are allthedata, blog, docs, explore, getstarted, interns, state, theory, and tools folders. If it does not belong in any of those folders, create a new folder in the www folder.
2. Navigate to the desired folder. Determine if the new page should be located in that folder or a subfolder of that folder. Create the necessary folders.
3. [If you are pulling the content from GitHub README you can skip this step.] Go to the Content folder, navigate or create the necessary folders. Make a html file in that folder, use html tags with your content (be sure to add ids to all headers. You do not need to include `<html>`, `<header>`, `<body>`, and `<footer>` tags. It should look something like this:
```html
<h1 id="data">Data</h1>
<p>Who’s On First is comprised of millions and millions of GeoJSON files. These files live in a GitHub organization called whosonfirst-data. The decision for this organization was spurred on by the work we’ve been doing to import venues and postal codes.</p>
<p>Work that has translated in to 24 million GeoJSON files spread across 488 GitHub repositories. Before we go any further, let’s be clear about one thing: This is not an ideal situation.</p>
<p>Ultimately our goal is to have a single monolithic Who’s On First repository that will contain all 24 million (and counting) records. In 2017 storing 24 million tiny files in a single Git repository is either technically impossible or so impractical as to “play impossible on TV”.</p>
<p>Explore the links to the left to learn more about our data.</p>
<h2 id="tl;dr">Tl;dr</h2>
<p>If you feel like throwing caution to the wind the Who’s On First data is available from the following places:</p>
<h3>Any individual Who’s On First ID</h3>
<p>https://whosonfirst.mapzen.com/data/{PATH}/{ID}.geojson for example: <a href="https://whosonfirst.mapzen.com/data/101/736/545/101736545.geojson">https://whosonfirst.mapzen.com/data/101/736/545/101736545.geojson</a></p> 
<h3 id="amazon-s3">Amazon S3</h3>
<p><a href="https://s3.amazonaws.com/whosonfirst.mapzen.com/data/">https://s3.amazonaws.com/whosonfirst.mapzen.com/data/</a> - see also: known knowns about S3 and why you shouldn't try to view that URL in a web browser</p>
<h3 id="GitHub">GitHub</h3>
<p><a href="https://GitHub.com/whosonfirst-data/whosonfirst-data/">https://GitHub.com/whosonfirst-data/whosonfirst-data/</a> — it's not complicated but but it is complex</p>
```
4. Go to the Makefile, make a new target with an appropriate name
```
[new_page]:
```
5. For subpages with GitHub content, add the following commands:
```
curl -s [github_readme_url] | pup -i 0 'article.markdown-body h1:first-of-type' > www/[final_desired_folders]/temp-content1.html
curl -s [github_readme_url] | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/[final_desired_folders]/temp-content2.html
```
For subpages with custom HTML content, add the following commands:
```
cat www/content/[custom_html_location] | pup -i 0 'body h1'  > www/[desired_final_folders]/temp-content1.html
cat www/content/[custom_html_location] | pup -i 0 'body :not(h1)'  > www/[desire_final_folders]/temp-content2.html
```
6. Add the following sed command to ensure that the h1 is treated correctly.
```
sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/temp-content1.html
```
7. Add the following cat command, with the appropriate components and the content from the cat or curl commands. 
```
cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/docs/subnav-top-onelevelup.html www/docs/temp-content1.html www/components/subnav/docs/subnav-bottom-onelevelup.html  www/docs/temp-content2.html www/components/footer/footer-onelevelup.html > www/[desired_final_url].html
```
8. If you page belongs in a first level category in the navbar, include the following sed command with appropriate fields.
```sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>[first_level_category]\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>[first_level_category]\<\/a\>/' www/[desired_final_url].html
```
9. Remove the following temporary files.
```
rm www/allthedata/pullrequest/temp-content1.html
rm www/allthedata/pullrequest/temp-content2.html
rm www/allthedata/pullrequest/temp-content1.html-e
```
10. If you page is utilizing subnav-top component with second level categories, include the following sed command with appropriate fields.
```
sed -i -e 's/whosonfirst\-sidenav\-link\"\>[new_page_name]/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>[new_page_name]/' www/[desired_final_url].html
```
11. If you page is utilizing subnav-bottom component with second level categories, include the following sed command with appropriate fields.
```
sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\-last\"\>[new_page_name]/whosonfirst\-extrasmall\-nav\-link\-collapsed\-last whosonfirst\-nav\-active\"\>[new_page_name]/' www/[desired_final_url].html
```
12. If you page is utilizing subnav-top component with second level categories, include the following sed command with appropriate fields.
```
sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>[page_name_in_component]\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>[new_page_name]\<\/div\>/' www/[desired_final_url].html
```
13. If you page is GitHub content, include the following sed command to create appropriately named anchors.
```
sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/[desired_final_url].html
```
14. Remove the following file.
```
rm www/allthedata/pullrequest/index.html-e
```
15. Navigate to the folder to the whosonfirst-www folder in your console. Run `make [new_page]`. The new page should now be created.