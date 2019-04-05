 if (Resource.where('name="Google Advanced Search"').count==0)
    r = Resource.new(:name=>'Google Advanced Search', :description=>'Use Google’s advanced search (based on date) to identify when it first went live.Note that Google lists results by relevance (not by date). You can define the date to be able to sort by date.', :tutorial=>'', :icon=>'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png', :url=>'https://www.google.com/advanced_search', :used_for_qs=>'nan', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Google Advanced Search"').update_all(description: 'Use Google’s advanced search (based on date) to identify when it first went live.Note that Google lists results by relevance (not by date). You can define the date to be able to sort by date.',tutorial: '',icon: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',url: 'https://www.google.com/advanced_search',:used_for_qs=>'nan', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="TinEye"').count==0)
    r = Resource.new(:name=>'TinEye', :description=>'A tool to identify fake/old images or videos by using reverse image searching. ', :tutorial=>'https://tineye.com/how', :icon=>'https://www.tineye.com/images/press/logo.png', :url=>'https://tineye.com/', :used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= h40Txuw1XuYJhbmLbDDVtdQ3g5o=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="TinEye"').update_all(description: 'A tool to identify fake/old images or videos by using reverse image searching. ',tutorial: 'https://tineye.com/how',icon: 'https://www.tineye.com/images/press/logo.png',url: 'https://tineye.com/',:used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= h40Txuw1XuYJhbmLbDDVtdQ3g5o=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Forensically"').count==0)
    r = Resource.new(:name=>'Forensically', :description=>'A website where you can upload images and see if they have been changed, and also look at metadata. ', :tutorial=>'https://29a.ch/2015/08/16/forensically-photo-forensics-for-the-web', :icon=>'https://29a.ch/photo-forensics/logo-32.cache-1b3e5ef06f154f06.png', :url=>'https://29a.ch/photo-forensics/#forensic-magnifier', :used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= roFOIXTl1WGZB4h3H9Wq1Ri5Dd4= 1YAbLBvLC0LOOyXlYhimI0AEX8g= GOv3F+BPywIEDxx/Igys5aRetOM= gCYtRcmeEhw6iLbiXUFkwACTRQ4=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Forensically"').update_all(description: 'A website where you can upload images and see if they have been changed, and also look at metadata. ',tutorial: 'https://29a.ch/2015/08/16/forensically-photo-forensics-for-the-web',icon: 'https://29a.ch/photo-forensics/logo-32.cache-1b3e5ef06f154f06.png',url: 'https://29a.ch/photo-forensics/#forensic-magnifier',:used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= roFOIXTl1WGZB4h3H9Wq1Ri5Dd4= 1YAbLBvLC0LOOyXlYhimI0AEX8g= GOv3F+BPywIEDxx/Igys5aRetOM= gCYtRcmeEhw6iLbiXUFkwACTRQ4=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="InVID"').count==0)
    r = Resource.new(:name=>'InVID', :description=>'This toolkit is provided by the InVID european project to help journalists to verify content on social networks. It is downloaded as a plugin. Provides contextual information, reverse image search, metadata about videos. ', :tutorial=>'https://www.invid-project.eu/tools-and-services/invid-verification-plugin/', :icon=>'https://www.invid-project.eu/wp-content/uploads/2016/03/invid-logo_def_rgb_200px-e1457008800691.png', :url=>'https://www.invid-project.eu/', :used_for_qs=>'LwLIF0bP0jMizwkxV6SvgpdaBoA=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="InVID"').update_all(description: 'This toolkit is provided by the InVID european project to help journalists to verify content on social networks. It is downloaded as a plugin. Provides contextual information, reverse image search, metadata about videos. ',tutorial: 'https://www.invid-project.eu/tools-and-services/invid-verification-plugin/',icon: 'https://www.invid-project.eu/wp-content/uploads/2016/03/invid-logo_def_rgb_200px-e1457008800691.png',url: 'https://www.invid-project.eu/',:used_for_qs=>'LwLIF0bP0jMizwkxV6SvgpdaBoA=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="WatchFrameByFrame"').count==0)
    r = Resource.new(:name=>'WatchFrameByFrame', :description=>'Provides a tool to slow down videos and look at them frame by frame. ', :tutorial=>'', :icon=>'http://www.watchframebyframe.com/static/sloth-2.svg', :url=>'http://www.watchframebyframe.com/', :used_for_qs=>'gCYtRcmeEhw6iLbiXUFkwACTRQ4=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="WatchFrameByFrame"').update_all(description: 'Provides a tool to slow down videos and look at them frame by frame. ',tutorial: '',icon: 'http://www.watchframebyframe.com/static/sloth-2.svg',url: 'http://www.watchframebyframe.com/',:used_for_qs=>'gCYtRcmeEhw6iLbiXUFkwACTRQ4=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Truepic"').count==0)
    r = Resource.new(:name=>'Truepic', :description=>'A pay-app. ', :tutorial=>'', :icon=>'https://truepic.com/wp-content/themes/truepic-website/images/logo-white@2x.png', :url=>'https://truepic.com/', :used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= roFOIXTl1WGZB4h3H9Wq1Ri5Dd4=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Truepic"').update_all(description: 'A pay-app. ',tutorial: '',icon: 'https://truepic.com/wp-content/themes/truepic-website/images/logo-white@2x.png',url: 'https://truepic.com/',:used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= roFOIXTl1WGZB4h3H9Wq1Ri5Dd4=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="YouTube Dataviewer"').count==0)
    r = Resource.new(:name=>'YouTube Dataviewer', :description=>'Find the video that wwas first uploaded. ', :tutorial=>'', :icon=>'https://toolsforreporters.com/wp-content/uploads/2018/03/1cd18fd7-91dd-4f81-bc96-770e3a2ab81a.png', :url=>'https://citizenevidence.amnestyusa.org/', :used_for_qs=>'LwLIF0bP0jMizwkxV6SvgpdaBoA= MdwlDEWe7iT3XMAvgK2FJSgiBfE=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="YouTube Dataviewer"').update_all(description: 'Find the video that wwas first uploaded. ',tutorial: '',icon: 'https://toolsforreporters.com/wp-content/uploads/2018/03/1cd18fd7-91dd-4f81-bc96-770e3a2ab81a.png',url: 'https://citizenevidence.amnestyusa.org/',:used_for_qs=>'LwLIF0bP0jMizwkxV6SvgpdaBoA= MdwlDEWe7iT3XMAvgK2FJSgiBfE=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Factcheck.org"').count==0)
    r = Resource.new(:name=>'Factcheck.org', :description=>'Search in the list if the source of the claim is listed on Factcheck.org using cmd+f. ', :tutorial=>'', :icon=>'https://www.asc.upenn.edu/sites/default/files/styles/landing_page_into_medium_small_width/public/images/factchecklogo.jpg?itok=0vDvfTtg', :url=>'https://www.factcheck.org/2017/07/websites-post-fake-satirical-stories/', :used_for_qs=>'xqpcnRZtClsRmMqRGa+/7y3dblk= Xl/0k6IBI85fWn2t9r/XgXG27EM=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Factcheck.org"').update_all(description: 'Search in the list if the source of the claim is listed on Factcheck.org using cmd+f. ',tutorial: '',icon: 'https://www.asc.upenn.edu/sites/default/files/styles/landing_page_into_medium_small_width/public/images/factchecklogo.jpg?itok=0vDvfTtg',url: 'https://www.factcheck.org/2017/07/websites-post-fake-satirical-stories/',:used_for_qs=>'xqpcnRZtClsRmMqRGa+/7y3dblk= Xl/0k6IBI85fWn2t9r/XgXG27EM=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Wikipedia\'s list of fake news websites"').count==0)
    r = Resource.new(:name=>'Wikipedia\'s list of fake news websites', :description=>'Wikipedia\'s list of fake news sources. ', :tutorial=>'', :icon=>'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Wikipedia-logo-v2-en.svg/220px-Wikipedia-logo-v2-en.svg.png', :url=>'https://en.wikipedia.org/wiki/List_of_fake_news_websites', :used_for_qs=>'Xl/0k6IBI85fWn2t9r/XgXG27EM= 5836sMdKW6bbJ9EZB48OgKMzri8=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Wikipedia\'s list of fake news websites"').update_all(description: 'Wikipedia\'s list of fake news sources. ',tutorial: '',icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Wikipedia-logo-v2-en.svg/220px-Wikipedia-logo-v2-en.svg.png',url: 'https://en.wikipedia.org/wiki/List_of_fake_news_websites',:used_for_qs=>'Xl/0k6IBI85fWn2t9r/XgXG27EM= 5836sMdKW6bbJ9EZB48OgKMzri8=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Godaddy"').count==0)
    r = Resource.new(:name=>'Godaddy', :description=>'A search tool to find out more about the source of the domain. ', :tutorial=>'', :icon=>'https://onlinedomain.com/wp-content/uploads/2016/04/GoDaddy-new-Logo-300x150.jpg', :url=>'', :used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Godaddy"').update_all(description: 'A search tool to find out more about the source of the domain. ',tutorial: '',icon: 'https://onlinedomain.com/wp-content/uploads/2016/04/GoDaddy-new-Logo-300x150.jpg',url: '',:used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Svenska Internetstiftelsen"').count==0)
    r = Resource.new(:name=>'Svenska Internetstiftelsen', :description=>'Search .se and .nu domain addresses. *Since 25 may 2018 they no longer show email address or domain owner because of GDPR.', :tutorial=>'', :icon=>'https://internetstiftelsen.se/app/uploads/2019/02/logotyp_positive-768x227.png', :url=>'https://internetstiftelsen.se/', :used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Svenska Internetstiftelsen"').update_all(description: 'Search .se and .nu domain addresses. *Since 25 may 2018 they no longer show email address or domain owner because of GDPR.',tutorial: '',icon: 'https://internetstiftelsen.se/app/uploads/2019/02/logotyp_positive-768x227.png',url: 'https://internetstiftelsen.se/',:used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="View DNS"').count==0)
    r = Resource.new(:name=>'View DNS', :description=>'Possible to fin IP adress of the domain and who manages it, other websites hosted on the same server and the location of the server. ', :tutorial=>'', :icon=>'https://viewdns.info/images/viewdns_logo.gif', :url=>'https://viewdns.info/', :used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA= +dHlKzEbS1m4ebgXCkw6J7L4ovY= L5wOcZmtlqrCcSAbC3qj1DX9Hrc=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="View DNS"').update_all(description: 'Possible to fin IP adress of the domain and who manages it, other websites hosted on the same server and the location of the server. ',tutorial: '',icon: 'https://viewdns.info/images/viewdns_logo.gif',url: 'https://viewdns.info/',:used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA= +dHlKzEbS1m4ebgXCkw6J7L4ovY= L5wOcZmtlqrCcSAbC3qj1DX9Hrc=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Media bias Fact Check"').count==0)
    r = Resource.new(:name=>'Media bias Fact Check', :description=>'A website with lists of news sources and their ratings. Also for checking if the source is biased. ', :tutorial=>'https://mediabiasfactcheck.com/methodology/', :icon=>'https://i0.wp.com/mediabiasfactcheck.com/wp-content/uploads/2017/04/globeredo-01.png?resize=150%2C150&ssl=1', :url=>'https://mediabiasfactcheck.com/', :used_for_qs=>'oiC4y5yFakzdwEW7s9Ab83eK60E=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Media bias Fact Check"').update_all(description: 'A website with lists of news sources and their ratings. Also for checking if the source is biased. ',tutorial: 'https://mediabiasfactcheck.com/methodology/',icon: 'https://i0.wp.com/mediabiasfactcheck.com/wp-content/uploads/2017/04/globeredo-01.png?resize=150%2C150&ssl=1',url: 'https://mediabiasfactcheck.com/',:used_for_qs=>'oiC4y5yFakzdwEW7s9Ab83eK60E=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Web of Trust "').count==0)
    r = Resource.new(:name=>'Web of Trust ', :description=>'A tool for manually checking if a website is trustworthy (by ratings) or downloaded as an application. ', :tutorial=>'', :icon=>'https://www.mywot.com/images/donutPlace.png', :url=>'https://www.mywot.com/', :used_for_qs=>'M7JKulcvkG2acY2ilfN1FhMdV80=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Web of Trust "').update_all(description: 'A tool for manually checking if a website is trustworthy (by ratings) or downloaded as an application. ',tutorial: '',icon: 'https://www.mywot.com/images/donutPlace.png',url: 'https://www.mywot.com/',:used_for_qs=>'M7JKulcvkG2acY2ilfN1FhMdV80=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Alexa"').count==0)
    r = Resource.new(:name=>'Alexa', :description=>'Search on your chosen website to check how many visits they have, from where, overlap audiences and sites that link to this page. ', :tutorial=>'', :icon=>'https://www.alexa.com/images/homepage/alexa-logo.png', :url=>'https://www.alexa.com/', :used_for_qs=>'Qcld+BiCDLdZddF3mLHY9qgyBWg=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Alexa"').update_all(description: 'Search on your chosen website to check how many visits they have, from where, overlap audiences and sites that link to this page. ',tutorial: '',icon: 'https://www.alexa.com/images/homepage/alexa-logo.png',url: 'https://www.alexa.com/',:used_for_qs=>'Qcld+BiCDLdZddF3mLHY9qgyBWg=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="SimilarWeb"').count==0)
    r = Resource.new(:name=>'SimilarWeb', :description=>'Available search tool to check a website\'s traffic, popularity and which pages that links to this website. ', :tutorial=>'', :icon=>'https://www.similarweb.com/corp/wp-content/uploads/2017/07/Screen-Shot-2017-07-24-at-10.21.34-300x109.png', :url=>'https://www.similarweb.com/', :used_for_qs=>'tlvjs3wxncN9Jh4AU5whSUqd1bo=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="SimilarWeb"').update_all(description: 'Available search tool to check a website\'s traffic, popularity and which pages that links to this website. ',tutorial: '',icon: 'https://www.similarweb.com/corp/wp-content/uploads/2017/07/Screen-Shot-2017-07-24-at-10.21.34-300x109.png',url: 'https://www.similarweb.com/',:used_for_qs=>'tlvjs3wxncN9Jh4AU5whSUqd1bo=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Google Images"').count==0)
    r = Resource.new(:name=>'Google Images', :description=>'Search image address or upload image to find images and search results associated with the image. ', :tutorial=>'', :icon=>'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/304px-Google_2015_logo.svg.png', :url=>'https://images.google.com/', :used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= h40Txuw1XuYJhbmLbDDVtdQ3g5o=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Google Images"').update_all(description: 'Search image address or upload image to find images and search results associated with the image. ',tutorial: '',icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/304px-Google_2015_logo.svg.png',url: 'https://images.google.com/',:used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= h40Txuw1XuYJhbmLbDDVtdQ3g5o=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Pipl"').count==0)
    r = Resource.new(:name=>'Pipl', :description=>'Seach for a person and find artikles they appear in and their social media accounts. ', :tutorial=>'', :icon=>'https://pipl.com/static/img/mobile-high/home_logo_300-min.png', :url=>'https://pipl.com/', :used_for_qs=>'tlvjs3wxncN9Jh4AU5whSUqd1bo=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Pipl"').update_all(description: 'Seach for a person and find artikles they appear in and their social media accounts. ',tutorial: '',icon: 'https://pipl.com/static/img/mobile-high/home_logo_300-min.png',url: 'https://pipl.com/',:used_for_qs=>'tlvjs3wxncN9Jh4AU5whSUqd1bo=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Twitter advanced search (eng)"').count==0)
    r = Resource.new(:name=>'Twitter advanced search (eng)', :description=>'Find tweets on specific subject, to a specific person etc. ', :tutorial=>'https://help.twitter.com/en/using-twitter/twitter-advanced-search', :icon=>'', :url=>'https://twitter.com/search-advanced?lang=sv&lang=en', :used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Twitter advanced search (eng)"').update_all(description: 'Find tweets on specific subject, to a specific person etc. ',tutorial: 'https://help.twitter.com/en/using-twitter/twitter-advanced-search',icon: '',url: 'https://twitter.com/search-advanced?lang=sv&lang=en',:used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Twitter avancerad sökning (sv)"').count==0)
    r = Resource.new(:name=>'Twitter avancerad sökning (sv)', :description=>'Find tweets on specific subject, to a specific person etc. ', :tutorial=>'https://help.twitter.com/en/using-twitter/twitter-advanced-search', :icon=>'', :url=>'https://twitter.com/search-advanced?lang=sv&lang=sv', :used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Twitter avancerad sökning (sv)"').update_all(description: 'Find tweets on specific subject, to a specific person etc. ',tutorial: 'https://help.twitter.com/en/using-twitter/twitter-advanced-search',icon: '',url: 'https://twitter.com/search-advanced?lang=sv&lang=sv',:used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Botcheck"').count==0)
    r = Resource.new(:name=>'Botcheck', :description=>'Check if an account is a bot or has many bot followers. Twitter account required. ', :tutorial=>'', :icon=>'', :url=>'https://botcheck.me/', :used_for_qs=>'ohjdiLHwUsnXC551J1EjaJFwJPo=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Botcheck"').update_all(description: 'Check if an account is a bot or has many bot followers. Twitter account required. ',tutorial: '',icon: '',url: 'https://botcheck.me/',:used_for_qs=>'ohjdiLHwUsnXC551J1EjaJFwJPo=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Botometer"').count==0)
    r = Resource.new(:name=>'Botometer', :description=>'Check if an account is a bot or has many bot followers. Twitter account required. ', :tutorial=>'', :icon=>'https://botometer.iuni.iu.edu/assets/img/banner-logo.png', :url=>'https://botometer.iuni.iu.edu/#!/', :used_for_qs=>'ohjdiLHwUsnXC551J1EjaJFwJPo=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Botometer"').update_all(description: 'Check if an account is a bot or has many bot followers. Twitter account required. ',tutorial: '',icon: 'https://botometer.iuni.iu.edu/assets/img/banner-logo.png',url: 'https://botometer.iuni.iu.edu/#!/',:used_for_qs=>'ohjdiLHwUsnXC551J1EjaJFwJPo=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Mapchecking"').count==0)
    r = Resource.new(:name=>'Mapchecking', :description=>'Check how many people can fit in an area to see if reporting is correct. ', :tutorial=>'', :icon=>'', :url=>'https://www.mapchecking.com/', :used_for_qs=>'ExbA5oj0BWhA14qhGPoC5dv2Oyw=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Mapchecking"').update_all(description: 'Check how many people can fit in an area to see if reporting is correct. ',tutorial: '',icon: '',url: 'https://www.mapchecking.com/',:used_for_qs=>'ExbA5oj0BWhA14qhGPoC5dv2Oyw=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Related Fact Checks"').count==0)
    r = Resource.new(:name=>'Related Fact Checks', :description=>'See if the article has failed a fact check before. ', :tutorial=>'', :icon=>'', :url=>'http://relatedfactchecks.org/', :used_for_qs=>'xqpcnRZtClsRmMqRGa+/7y3dblk= oiC4y5yFakzdwEW7s9Ab83eK60E=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Related Fact Checks"').update_all(description: 'See if the article has failed a fact check before. ',tutorial: '',icon: '',url: 'http://relatedfactchecks.org/',:used_for_qs=>'xqpcnRZtClsRmMqRGa+/7y3dblk= oiC4y5yFakzdwEW7s9Ab83eK60E=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Alla bolag"').count==0)
    r = Resource.new(:name=>'Alla bolag', :description=>'Check economy, addresses and members on the board on Swedish companies. ', :tutorial=>'', :icon=>'https://www.allabolag.se/Assets/img/logo_horizontal_flat.svg', :url=>'http://allabolag.se', :used_for_qs=>'L5wOcZmtlqrCcSAbC3qj1DX9Hrc=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Alla bolag"').update_all(description: 'Check economy, addresses and members on the board on Swedish companies. ',tutorial: '',icon: 'https://www.allabolag.se/Assets/img/logo_horizontal_flat.svg',url: 'http://allabolag.se',:used_for_qs=>'L5wOcZmtlqrCcSAbC3qj1DX9Hrc=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Stalk Scan "').count==0)
    r = Resource.new(:name=>'Stalk Scan ', :description=>'Look up someone\'s facebook profile. ', :tutorial=>'', :icon=>'https://stalkscan.com/img/logo2.png', :url=>'https://stalkscan.com/', :used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Stalk Scan "').update_all(description: 'Look up someone\'s facebook profile. ',tutorial: '',icon: 'https://stalkscan.com/img/logo2.png',url: 'https://stalkscan.com/',:used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Intel Techniques"').count==0)
    r = Resource.new(:name=>'Intel Techniques', :description=>'Check social media accounts - liked posts, interactions, accounts with certain interests etc. ', :tutorial=>'', :icon=>'https://inteltechniques.com/img/ToolHeader.png', :url=>'https://inteltechniques.com/menu.html', :used_for_qs=>'ohjdiLHwUsnXC551J1EjaJFwJPo=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Intel Techniques"').update_all(description: 'Check social media accounts - liked posts, interactions, accounts with certain interests etc. ',tutorial: '',icon: 'https://inteltechniques.com/img/ToolHeader.png',url: 'https://inteltechniques.com/menu.html',:used_for_qs=>'ohjdiLHwUsnXC551J1EjaJFwJPo=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Yandex"').count==0)
    r = Resource.new(:name=>'Yandex', :description=>'Find similar images. This tool is especially useful for face recognition. ', :tutorial=>'', :icon=>'https://avatars.mds.yandex.net/get-bunker/50064/9c8dea8c94b9bea5ef1677932c8272cbfca4995a/orig', :url=>'https://yandex.com/images/', :used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= h40Txuw1XuYJhbmLbDDVtdQ3g5o=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Yandex"').update_all(description: 'Find similar images. This tool is especially useful for face recognition. ',tutorial: '',icon: 'https://avatars.mds.yandex.net/get-bunker/50064/9c8dea8c94b9bea5ef1677932c8272cbfca4995a/orig',url: 'https://yandex.com/images/',:used_for_qs=>'GOv3F+BPywIEDxx/Igys5aRetOM= h40Txuw1XuYJhbmLbDDVtdQ3g5o=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Wikipedias lista över svenska nyheter ordnade efter ideologi"').count==0)
    r = Resource.new(:name=>'Wikipedias lista över svenska nyheter ordnade efter ideologi', :description=>'List of swedish newspapers accoring to ideology. ', :tutorial=>'', :icon=>'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Wikipedia-logo-v2-en.svg/220px-Wikipedia-logo-v2-en.svg.png', :url=>'https://sv.wikipedia.org/wiki/Lista_%C3%B6ver_svenska_tidningar_ordnade_efter_ideologi', :used_for_qs=>'3zEwscoBkWu9uo/lx1yzFz/NM2s= Xl/0k6IBI85fWn2t9r/XgXG27EM=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Wikipedias lista över svenska nyheter ordnade efter ideologi"').update_all(description: 'List of swedish newspapers accoring to ideology. ',tutorial: '',icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Wikipedia-logo-v2-en.svg/220px-Wikipedia-logo-v2-en.svg.png',url: 'https://sv.wikipedia.org/wiki/Lista_%C3%B6ver_svenska_tidningar_ordnade_efter_ideologi',:used_for_qs=>'3zEwscoBkWu9uo/lx1yzFz/NM2s= Xl/0k6IBI85fWn2t9r/XgXG27EM=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="WHOIS"').count==0)
    r = Resource.new(:name=>'WHOIS', :description=>'A search tool to find out more about the source of the domain. ', :tutorial=>'', :icon=>'https://whois.net/images/home/whois.png', :url=>'https://whois.net/', :used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="WHOIS"').update_all(description: 'A search tool to find out more about the source of the domain. ',tutorial: '',icon: 'https://whois.net/images/home/whois.png',url: 'https://whois.net/',:used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Ratsit"').count==0)
    r = Resource.new(:name=>'Ratsit', :description=>'Search for people\'s number, addresses and company. ', :tutorial=>'', :icon=>'', :url=>'https://www.ratsit.se/', :used_for_qs=>'L5wOcZmtlqrCcSAbC3qj1DX9Hrc=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Ratsit"').update_all(description: 'Search for people\'s number, addresses and company. ',tutorial: '',icon: '',url: 'https://www.ratsit.se/',:used_for_qs=>'L5wOcZmtlqrCcSAbC3qj1DX9Hrc=', :updated_at=>Time.now.getutc)
 end

