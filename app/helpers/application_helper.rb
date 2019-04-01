module ApplicationHelper
  include Pagy::Frontend

  def try_resource(resource_name)
    results=""
    name=resource_name.downcase
    resource = Resource.where("name=?",resource_name).first

    #Google fact-check resource
    if name.include? "google" and name.include? "fact"
      if (@claim.present?)
        results="<strong><a href='"+resource.url+@claim.title+"' target=_blank>Search title</a></strong>"
        if (!@claim.url_preview.blank?)
            if (@claim.url_preview.include? "<p")
              description=@claim.url_preview.match(/<p[^>]+?>([^<]+)/)[1]
              if (!description.blank?)
                results=results+" - <strong><a href='"+resource.url+description+"' target=_blank>Search description</a></strong>"
              end
            end
        end
        results=results+" using "
     end
    end

    #Google Reverse Image Search
    if name.include? "google" and name.include? "image"
      if @claim.present?
        results="<strong><a href='https://www.google.com/searchbyimage?image_url="+@claim.url+"' target=_blank>Reverse image search</a></strong> using "
      end
    end

    #WatchFrameByFrame
    if name.include? "watchframebyframe"
      if @claim.present?
        if (@claim.url.include? "youtube.com" or @claim.url.include? "youtu.be" or @claim.url.include? "vimeo.com")
          results="<strong><a href='http://www.watchframebyframe.com/search?search="+@claim.url+"' target=_blank>Open video</a></strong> using "
        end
      end
    end

    #List of fake websites
    if name.include? "list" and name.include? "fake"
      if (@medium.present?)
        results="<strong><a href='https://www.google.com/search?q="+@medium.name+"+site%3A"+resource.url+"' target=_blank>Check if medium is blacklisted</a></strong> on "
      end
    end

    #Related Fact Checks
    if resource.url.downcase.include? "mediabiasfactcheck.com"
      if (@medium.present?)
        results="<strong><a href='"+resource.url+"/?s="+@medium.name+"' target=_blank>Check if media is rated</a></strong> by "
      end
    end

    #Related Fact Checks
    if resource.url.downcase.include? "relatedfactchecks.org"
      if (@claim.present?)
        results="<strong><a href='"+resource.url+"/search?url="+@claim.url+"' target=_blank>Check if claim is already fact-checked</a></strong> using "
      end
    end


    return results
  end


end
