from bs4 import BeautifulSoup as bs
import requests
import os
import sys

"""
This script is designed to crawl the wiki links of block documentation page.
It will create .rst files for each block to be passed to Sphinx for new
readthedocs auto-generation. 
Pass in folder path that contains 'html and 'rst' directories from terminal.
"""
folderpath = sys.argv[1]
head_url = "https://casper.berkeley.edu"
source_url = "/wiki/Block_Documentation"
source_html = requests.get(head_url + source_url)
plain_text = source_html.text
soup = bs(plain_text,"html.parser")
# LIST OF LINKS WE DON'T CARE ABOUT
ignore_list = ['/wiki/Block_Documentation']
ignore_list.append('/wiki/Main_Page')
ignore_list.append('/wiki/Libraries')
ignore_list.append('/wiki/Toolflow')
ignore_list.append('/wiki/Hardware')
ignore_list.append('/wiki/Software')
ignore_list.append('/wiki/Projects')
ignore_list.append('/wiki/Tutorials')
ignore_list.append('/wiki/Memos')
ignore_list.append('/wiki/Papers')
ignore_list.append('/wiki/Videos')
ignore_list.append('/wiki/FAQ')

links = []
# parse content and extract all links
# links are <a href="/wiki/" that don't contain a colon
for link in soup.find_all("a", href=True):
    link = str(link['href'])
    if ("/wiki/" in link) and (":" not in link) and (link not in ignore_list):
        links.append(link)

# loop over each link and visit it:
# - extract the content
# - write it to a new html file
for doc_url in links:
    doc_name = doc_url[6:]
    link_html = requests.get(head_url + doc_url)
    link_text = link_html.text
    start_index = link_text.find('<!-- start content -->')
    end_index = link_text.find('NewPP') - 7
    content = link_text[start_index:end_index]
    # write content to html file
    file = open(folderpath + "html/" + doc_name + ".html", 'w')
    file.write(content)
    file.close()
    # use pandoc to convert the html into a .rst file for Sphinx
    os.system("pandoc -s -f html -t rst %shtml/%s.html -o %srst/%s.rst" %(folderpath, doc_name, folderpath, doc_name))