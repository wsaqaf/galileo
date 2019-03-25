Resource.delete_all
 if (Resource.where('name="Google Advanced Search"').count==0)
    r = Resource.new(:name=>'Google Advanced Search', :description=>'Use Google’s advanced search (based on date) to identify when it first went live.Note that Google lists results by relevance (not by date). You can define the date to be able to sort by date.', :tutorial=>'', :icon=>'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png', :url=>'https://www.google.com/advanced_search', :used_for_qs=>'MdwlDEWe7iT3XMAvgK2FJSgiBfE=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Google Advanced Search"').update_all(description: 'Use Google’s advanced search (based on date) to identify when it first went live.Note that Google lists results by relevance (not by date). You can define the date to be able to sort by date.',tutorial: '',icon: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',url: 'https://www.google.com/advanced_search',:used_for_qs=>'MdwlDEWe7iT3XMAvgK2FJSgiBfE=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Wikipedia\'s list of fake news websites"').count==0)
    r = Resource.new(:name=>'Wikipedia\'s list of fake news websites', :description=>'Wikipedia\'s list of fake news sources. ', :tutorial=>'', :icon=>'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Wikipedia-logo-v2-en.svg/220px-Wikipedia-logo-v2-en.svg.png', :url=>'https://en.wikipedia.org/wiki/List_of_fake_news_websites', :used_for_qs=>'xqpcnRZtClsRmMqRGa+/7y3dblk=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Wikipedia\'s list of fake news websites"').update_all(description: 'Wikipedia\'s list of fake news sources. ',tutorial: '',icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Wikipedia-logo-v2-en.svg/220px-Wikipedia-logo-v2-en.svg.png',url: 'https://en.wikipedia.org/wiki/List_of_fake_news_websites',:used_for_qs=>'xqpcnRZtClsRmMqRGa+/7y3dblk=', :updated_at=>Time.now.getutc)
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
    r = Resource.new(:name=>'Mapchecking', :description=>'Check how many people can fit in an area to see if reporting is correct. ', :tutorial=>'', :icon=>'', :url=>'https://www.mapchecking.com/', :used_for_qs=>'nan', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Mapchecking"').update_all(description: 'Check how many people can fit in an area to see if reporting is correct. ',tutorial: '',icon: '',url: 'https://www.mapchecking.com/',:used_for_qs=>'nan', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Alla bolag"').count==0)
    r = Resource.new(:name=>'Alla bolag', :description=>'Check economy, addresses and members on the board on Swedish companies. ', :tutorial=>'', :icon=>'https://www.allabolag.se/Assets/img/logo_horizontal_flat.svg', :url=>'http://allabolag.se', :used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Alla bolag"').update_all(description: 'Check economy, addresses and members on the board on Swedish companies. ',tutorial: '',icon: 'https://www.allabolag.se/Assets/img/logo_horizontal_flat.svg',url: 'http://allabolag.se',:used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Stalk Scan "').count==0)
    r = Resource.new(:name=>'Stalk Scan ', :description=>'Look up someone\'s facebook profile. ', :tutorial=>'', :icon=>'https://stalkscan.com/img/logo2.png', :url=>'https://stalkscan.com/', :used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Stalk Scan "').update_all(description: 'Look up someone\'s facebook profile. ',tutorial: '',icon: 'https://stalkscan.com/img/logo2.png',url: 'https://stalkscan.com/',:used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Intel Techniques"').count==0)
    r = Resource.new(:name=>'Intel Techniques', :description=>'Check social media accounts - liked posts, interactions, accounts with certain interests etc. ', :tutorial=>'', :icon=>'https://inteltechniques.com/img/ToolHeader.png', :url=>'https://inteltechniques.com/menu.html', :used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Intel Techniques"').update_all(description: 'Check social media accounts - liked posts, interactions, accounts with certain interests etc. ',tutorial: '',icon: 'https://inteltechniques.com/img/ToolHeader.png',url: 'https://inteltechniques.com/menu.html',:used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="WHOIS"').count==0)
    r = Resource.new(:name=>'WHOIS', :description=>'A search tool to find out more about the source of the domain. ', :tutorial=>'', :icon=>'https://whois.net/images/home/whois.png', :url=>'https://whois.net/', :used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="WHOIS"').update_all(description: 'A search tool to find out more about the source of the domain. ',tutorial: '',icon: 'https://whois.net/images/home/whois.png',url: 'https://whois.net/',:used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Google Advanced Search"').count==0)
    r = Resource.new(:name=>'Google Advanced Search', :description=>'Use Google’s advanced search (based on date) to identify when it first went live.Note that Google lists results by relevance (not by date). You can define the date to be able to sort by date.', :tutorial=>'', :icon=>'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png', :url=>'https://www.google.com/advanced_search', :used_for_qs=>'MdwlDEWe7iT3XMAvgK2FJSgiBfE=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Google Advanced Search"').update_all(description: 'Use Google’s advanced search (based on date) to identify when it first went live.Note that Google lists results by relevance (not by date). You can define the date to be able to sort by date.',tutorial: '',icon: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',url: 'https://www.google.com/advanced_search',:used_for_qs=>'MdwlDEWe7iT3XMAvgK2FJSgiBfE=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Wikipedia\'s list of fake news websites"').count==0)
    r = Resource.new(:name=>'Wikipedia\'s list of fake news websites', :description=>'Wikipedia\'s list of fake news sources. ', :tutorial=>'', :icon=>'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Wikipedia-logo-v2-en.svg/220px-Wikipedia-logo-v2-en.svg.png', :url=>'https://en.wikipedia.org/wiki/List_of_fake_news_websites', :used_for_qs=>'xqpcnRZtClsRmMqRGa+/7y3dblk=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Wikipedia\'s list of fake news websites"').update_all(description: 'Wikipedia\'s list of fake news sources. ',tutorial: '',icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Wikipedia-logo-v2-en.svg/220px-Wikipedia-logo-v2-en.svg.png',url: 'https://en.wikipedia.org/wiki/List_of_fake_news_websites',:used_for_qs=>'xqpcnRZtClsRmMqRGa+/7y3dblk=', :updated_at=>Time.now.getutc)
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
    r = Resource.new(:name=>'Mapchecking', :description=>'Check how many people can fit in an area to see if reporting is correct. ', :tutorial=>'', :icon=>'', :url=>'https://www.mapchecking.com/', :used_for_qs=>'nan', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Mapchecking"').update_all(description: 'Check how many people can fit in an area to see if reporting is correct. ',tutorial: '',icon: '',url: 'https://www.mapchecking.com/',:used_for_qs=>'nan', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Alla bolag"').count==0)
    r = Resource.new(:name=>'Alla bolag', :description=>'Check economy, addresses and members on the board on Swedish companies. ', :tutorial=>'', :icon=>'https://www.allabolag.se/Assets/img/logo_horizontal_flat.svg', :url=>'http://allabolag.se', :used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Alla bolag"').update_all(description: 'Check economy, addresses and members on the board on Swedish companies. ',tutorial: '',icon: 'https://www.allabolag.se/Assets/img/logo_horizontal_flat.svg',url: 'http://allabolag.se',:used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Stalk Scan "').count==0)
    r = Resource.new(:name=>'Stalk Scan ', :description=>'Look up someone\'s facebook profile. ', :tutorial=>'', :icon=>'https://stalkscan.com/img/logo2.png', :url=>'https://stalkscan.com/', :used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Stalk Scan "').update_all(description: 'Look up someone\'s facebook profile. ',tutorial: '',icon: 'https://stalkscan.com/img/logo2.png',url: 'https://stalkscan.com/',:used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="Intel Techniques"').count==0)
    r = Resource.new(:name=>'Intel Techniques', :description=>'Check social media accounts - liked posts, interactions, accounts with certain interests etc. ', :tutorial=>'', :icon=>'https://inteltechniques.com/img/ToolHeader.png', :url=>'https://inteltechniques.com/menu.html', :used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="Intel Techniques"').update_all(description: 'Check social media accounts - liked posts, interactions, accounts with certain interests etc. ',tutorial: '',icon: 'https://inteltechniques.com/img/ToolHeader.png',url: 'https://inteltechniques.com/menu.html',:used_for_qs=>'5btMJl56WhWo3QfOZaZIxVNTnQs=', :updated_at=>Time.now.getutc)
 end

 if (Resource.where('name="WHOIS"').count==0)
    r = Resource.new(:name=>'WHOIS', :description=>'A search tool to find out more about the source of the domain. ', :tutorial=>'', :icon=>'https://whois.net/images/home/whois.png', :url=>'https://whois.net/', :used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :user_id=>2, :created_at=>Time.now.getutc, :updated_at=>Time.now.getutc)
    r.save
 else
    Resource.where('name="WHOIS"').update_all(description: 'A search tool to find out more about the source of the domain. ',tutorial: '',icon: 'https://whois.net/images/home/whois.png',url: 'https://whois.net/',:used_for_qs=>'4WkZ+Yevia+di60kyklYqhHw5GA=', :updated_at=>Time.now.getutc)
 end

