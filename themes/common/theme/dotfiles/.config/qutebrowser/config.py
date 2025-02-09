config.load_autoconfig()
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}'}
c.url.default_page = 'https://duckduckgo.com/'
c.url.start_pages = ['https://duckduckgo.com/']
{{ (datasource "variables").qutebrowser.theme | default "" }}
