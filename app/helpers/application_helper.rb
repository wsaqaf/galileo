module ApplicationHelper
  include Pagy::Frontend

  def try_resource(resource_name,type)
    results=""
    name_field=""
    domain_name=""
    if (type=="medium") then obj=@medium; elsif (type=="src") then obj=@src; else obj=@claim; end
    if type=="claim" then name_field=obj.title else name_field=obj.name; end
    if (type=="src") then type="source"; end
    if (obj.present?)
      if (obj.url.present?)
        begin
          domain_name=URI.parse(obj.url).host
          domain_name=domain_name.sub(/^www\./, '')
        rescue
          domain_name=obj.url
        end
      end
    end
    name=resource_name.downcase
    resource = Resource.where("name=?",resource_name).first

##################################################

#Image-related resources

#Google Reverse Image Search
    if name.include? "google" and name.include? "image"
      if domain_name
        if !obj.url_preview.nil?
          img=obj.url_preview.scan(/img src=\\"([^<>]*?)\\"/).first
          if !img.nil?
            img=img[0]
            results="<strong><a href='https://www.google.com/searchbyimage?image_url="+img.to_s+"' target=_blank>Reverse image search</a></strong> using "
          else
            results="<strong><a href='https://www.google.com/searchbyimage?image_url="+obj.url+"' target=_blank>Reverse image search</a></strong> using "
          end
        end
      end
    end

    if name.include? "yandex"
      if domain_name
        if !obj.url_preview.nil?
          img=obj.url_preview.scan(/img src=\\"([^<>]*?)\\"/).first
          if !img.nil?
            img=img[0]
            results="<strong><a href='https://yandex.com/images/search?source=collections&url="+img.to_s+"&rpt=imageview' target=_blank>Reverse image search</a></strong> using "
          else
            results="<strong><a href='https://yandex.com/images/search?source=collections&url="+obj.url+"&rpt=imageview' target=_blank>Reverse image search</a></strong> using "
          end
        end
      end
    end

#META DATA (EXIF) data extractor

if name.include? "metapicz"
    if !obj.url_preview.nil?
      img=obj.url_preview.scan(/img src=\\"([^<>]*?)\\"/).first
      if !img.nil?
        img=img[0]
        results="<strong><a href='http://metapicz.com/#landing?imgsrc="+img.to_s+"' target=_blank>View metadata </a></strong> using "
      else
        results="<strong><a href='http://metapicz.com/#landing?imgsrc="+obj.url+"' target=_blank>View metadata </a></strong> using "
      end
    end
end

##################################################

#video-related resources

#### Inteltechniques video reverse search
if name.include? "inteltechniques reverse"
  results="<strong><a href='https://inteltechniques.com/menu/pages/reverse.video.tool.html' target=_blank>Reverse search the video</a></strong> using "
end

#WatchFrameByFrame
    if name.include? "watchframebyframe"
      if domain_name
        if (obj.url.include? "youtube.com" or obj.url.include? "youtu.be" or obj.url.include? "vimeo.com")
          results="<strong><a href='http://www.watchframebyframe.com/search?search="+obj.url+"' target=_blank>Open video</a></strong> using "
        end
      end
    end

#WatchFrameByFrame
    if name.include? "invid"
      results="<strong><a href='https://chrome.google.com/webstore/detail/mhccpoafgdgbhnjfhkcmgknndkeenfhe' target=_blank>Download</a> and use the browser plugin</a></strong> from "
    end

##################################################

#content-related and general resources
##################################################

###### Google search for fact-checked stories
    if name.include? "google" and name.include? "search"

      if (obj.present?)
        results="<strong><a href='https://www.google.com/search?q=\"fact-check\"+"+name_field+"' target=_blank>Search about it </a></strong>"
        if (!obj.url_preview.blank?)
            if (obj.url_preview.include? "<p")
              description=obj.url_preview.match(/<p[^>]+?>([^<]+)/)[1]
              if (!description.blank?)
                results=results+" - <strong><a href='https://www.google.com/search?q=\"fact-check\"+"+description.gsub('\\"', '"')+"' target=_blank>Search description</a></strong>"
              end
            end
        end
        results=results+" using "
     end
    end

#### List of fake websites on wikipedia and factcheck.org (using Google search)
    if name.include? "wikipedia" or name.include? "factcheck.org"
      if (!domain_name.blank?)
        results="<strong><a href='https://www.google.com/search?q="+domain_name+"+site%3A"+resource.url+"' target=_blank>Check if "+type+" is blacklisted</a></strong> on "
      else
        results="<strong><a href='https://www.google.com/search?q="+name_field+"+site%3A"+resource.url+"' target=_blank>Check if "+type+" is blacklisted</a></strong> on "
      end
    end

###### Media Bias Fact Check
    if name.include? "media" and name.include? "bias"
      results="<strong><a href='https://mediabiasfactcheck.com/?s="+name_field+"' target=_blank>Check ratings of the "+type+" </a>"
      if (!domain_name.blank?)
        results=results+" or its <a href='https://mediabiasfactcheck.com/?s="+domain_name+"' target=_blank>URL</a></strong> using "
      end
    end

#####Related Fact Checks
    if name.include? "related" and name.include? "factchecks"
      if (!domain_name.blank?)
          results="<strong><a href='https://relatedfactchecks.org/search?url="+obj.url+"' target=_blank>Check if claim was fact-checked</a></strong> using "
      end
    end

#####Web of Trust
    if name.include? "web" and name.include? "trust"
      if (!domain_name.blank?)
          results="<strong><a href='https://www.mywot.com/en/scorecard/"+domain_name+"' target=_blank>Check the website's reputation</a></strong> by "
      end
    end

#### ViewDNS
    if name.include? "viewdns" or name.include? "view dns"
      if (!domain_name.blank?)
          results="<strong><a href='https://viewdns.info/whois/?domain="+domain_name+"' target=_blank>Get domain's WHOIS details</a></strong> using "
      end
    end

##### Alexa website ranking
    if name.include? "alexa"
      if (!domain_name.blank?)
          results="<strong><a href='https://www.alexa.com/siteinfo/"+domain_name+"' target=_blank>Get domain's ranking</a></strong> using "
      end
    end

#### SimilarWeb
    if name.include? "similarweb" or name.include? "similar web"
      if (!domain_name.blank?)
          results="<strong><a href='https://www.similarweb.com/website/"+domain_name+"' target=_blank>Get information about the domain</a></strong> using "
      end
    end

#### Pipl
    if name.include? "pipl"
      results="<strong><a href='https://pipl.com/search/?q="+name_field+"' target=_blank>Learn more about this "+type+"</a></strong> using "
    end

#### Inteltechniques person search
    if name.include? "inteltechniques person"
      results="<strong><a href='https://inteltechniques.com/menu/pages/person.tool.html' target=_blank>Research the source</a></strong> using "
    end

##### Twitter search
    if name.include? "twitter"
      results="<strong><a href='https://twitter.com/search?l=&q=%22"+name_field+"%22&src=typd&lang=en' target=_blank>Search this "+type+"</a></strong> on "
    end

####### Real or Satire
    if name.include? "real" and name.include? "satire"
      if (!domain_name.blank?)
          results="<strong><a href='https://realorsatire.com/?s="+domain_name+"' target=_blank>See if the "+type+" is satire or real</a></strong> using "
      end
    end

####### Assessing stories with unnamed sources
    if name.include? "assess" and name.include? "unnamed sources"
      results="<strong><a href='"+resource.url+"' target=_blank>Read tips</a></strong> on "
    end

####### Detecting clickbait titles
    if name.include? "clickbait" and name.include? "title"
      results="<strong><a href='"+resource.url+"' target=_blank>Read tips</a></strong> on "

    end

#######################################################################
    return results
  end


end
