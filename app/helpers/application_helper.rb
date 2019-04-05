module ApplicationHelper
  include Pagy::Frontend

  def try_resource(resource_name,type)
    results=""
    name_field=""
    url_field=""
    if (type=="medium") then obj=@medium; elsif (type=="src") then obj=@src; else obj=@claim; end
    if type=="claim" then name_field=obj.title else name_field=obj.name; end
    if (obj.present?)
      if (obj.url.present?)
        begin
          url_field=URI.parse(obj.url).host
        rescue
          url_field=obj.url
        end
      end
    end
    name=resource_name.downcase
    resource = Resource.where("name=?",resource_name).first

##################################################
    #Image-related resources

    #Google Reverse Image Search
    if name.include? "google" and name.include? "image"
      if url_field
        results="<strong><a href='https://www.google.com/searchbyimage?image_url="+obj.url+"' target=_blank>Reverse image search</a></strong> using "
      end
    end

    if name.include? "yandex"
      if url_field
        results="<strong><a href='https://yandex.com/images/search?source=collections&url="+obj.url+"&rpt=imageview' target=_blank>Reverse image search</a></strong> using "
      end
    end


##################################################
    #video-related resources

    #WatchFrameByFrame
    if name.include? "watchframebyframe"
      if url_field
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


    #Google fact-check resource
    if name.include? "google" and name.include? "search"

      if (obj.present?)
        results="<strong><a href='https://www.google.com/search?q=\"fact-check\"+"+name_field+"' target=_blank>Search title</a></strong>"
        if (!obj.url_preview.blank?)
            if (obj.url_preview.include? "<p")
              description=obj.url_preview.match(/<p[^>]+?>([^<]+)/)[1]
              if (!description.blank?)
                results=results+" - <strong><a href='https://www.google.com/search?q=\"fact-check\"+"+description+"' target=_blank>Search description</a></strong>"
              end
            end
        end
        results=results+" using "
     end
    end

    #List of fake websites
    if name.include? "wikipedia" or name.include? "factcheck.org"
      if (!url_field.blank?)
        results="<strong><a href='https://www.google.com/search?q="+url_field+"+site%3A"+resource.url+"' target=_blank>Check if medium is blacklisted</a></strong> on "
      else
        results="<strong><a href='https://www.google.com/search?q="+name_field+"+site%3A"+resource.url+"' target=_blank>Check if medium is blacklisted</a></strong> on "
      end
    end

    #Related Fact Checks
    if name.include? "media" and name.include? "bias"
      results="<strong><a href='https://mediabiasfactcheck.com/?s="+name_field+"' target=_blank>Check ratings of the medium </a>"
      if (!url_field.blank?)
        results=results+" or its <a href='https://mediabiasfactcheck.com/?s="+url_field+"' target=_blank>website</a></strong> using "
      end
    end

    #Related Fact Checks
    if name.include? "related" and name.include? "factchecks"
      if (!url_field.blank?)
          results="<strong><a href='https://relatedfactchecks.org/search?url="+obj.url+"' target=_blank>Check if claim was fact-checked</a></strong> using "
      end
    end

    #Web of Trust
    if name.include? "web" and name.include? "trust"
      if (!url_field.blank?)
          results="<strong><a href='https://www.mywot.com/en/scorecard/"+url_field+"' target=_blank>Check the medium's reputation</a></strong> by "
      end
    end

    return results
  end


end
