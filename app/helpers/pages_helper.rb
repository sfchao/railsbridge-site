module PagesHelper
  
  def sponsor(link, image, title, text)
    "<div class='sponsor'><div class='logo'>" +
    link_to(image_tag("sponsors/#{image}", {:alt => title, :title => title}), link, :rel => "external") +
    "</div><div class='plug'><p>#{text}</p></div><div class='clear'></div></div>"
   end
  
end