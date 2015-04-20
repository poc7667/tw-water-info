class WaterImage
 def self.get_image_by_percentage(percentage)
    if percentage > 70
      return "good"
    elsif percentage > 40 
      return "soso"
    else
      return "bad"
    end
  end
end