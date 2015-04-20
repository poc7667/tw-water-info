class ReservoirsScreen < PM::TableScreen
  refreshable callback: :on_refresh
  title "台灣水庫水情資訊"
  def on_load
    $returned_data = [{title: 'nil'}]
    on_refresh
  end

  def table_data
    [{
        cells: $returned_data.map do |reservoir|
          {
            title: reservoir["title"],
            action: :select_reservoir,
            image:{
              image: reservoir["image"],
              radius: 15
              },
            arguments: { reservoir: reservoir["title"] }
          }
        end
    }]
  end

  def select_reservoir(reservoir)
    PM.logger.info reservoir
  end 

  def on_refresh
    start_refreshing
    get_reserviors
    update_table_data
    stop_refreshing
  end  

  def get_reserviors
    # https://github.com/washwashsleep/TaiwanReservoirAPI
    url_string = "http://128.199.223.114:10080/"
    AFMotion::JSON.get(url_string) do |result|
      if result.success?
        $returned_data = []
        sorted_data = result.object["data"].sort_by{|h| get_percentage(h["immediatePercentage"])}
        sorted_data.each do |r|
          $returned_data << {
            "title" => [r["reservoirName"], r["immediatePercentage"]].join(":"),
            "value" => get_percentage(r["immediatePercentage"]),
            "image" => WaterImage.get_image_by_percentage(get_percentage(r["immediatePercentage"]))
          }
        end
        update_table_data
      end      
    end 
  end

  def get_percentage(data)
    return data.scan(/\d+\.\d+/).first.to_f
  end


end