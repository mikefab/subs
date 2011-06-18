module RatingsHelper
  def star_button(f, cap, value, checked)
     radio_button_tag("rating[#{cap.id}]", value, checked, :class => 'star')
   end
   
 
end
