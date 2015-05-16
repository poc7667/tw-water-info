class SortDamsScreen < PM::TableScreen
  longpressable
  def on_init
    navigationItem.hidesBackButton = false
    set_nav_bar_button :back, title: 'Cancel', style: :plain, action: :back
    get_reserviors
    update_table_data    
  end  


  def on_load
    $returned_data = [{title: 'nil'}]
    toggle_edit_mode
  end

  def on_cell_moved(args)
  # Do something here
    p args
  end

  def table_data
    [{
        cells: $returned_data.map do |reservoir|
          {
            title: reservoir["title"],
            subtitle: reservoir["subtitle"],
            moveable: true,
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
  def get_reserviors
    # https://github.com/washwashsleep/TaiwanReservoirAPI
    AFMotion::JSON.get(RESERVOIR_API_URL) do |result|
      if result.success?
        $returned_data = []
        sorted_data = result.object["data"].sort_by{|h| get_percentage(h["immediatePercentage"])}
        sorted_data.each do |r|
          reservoir = {
            "title" => [r["reservoirName"], r["immediatePercentage"]].join(":"),
            "value" => get_percentage(r["immediatePercentage"]),
            "last_update_at" => r["lastedUpdateTime"].to_s,
            "income" => r["daliyInflow"].to_f - r["daliyOverflow"].to_f ,
            "baseAvailable" => r["baseAvailable"].gsub(',', '').to_f,
            "image" => WaterImage.get_image_by_percentage(get_percentage(r["immediatePercentage"]))
          }
          reservoir["delta"] = get_delta(reservoir)
          reservoir["subtitle"] = reservoir["delta"].to_s + "  " + reservoir["last_update_at"]
          $returned_data << reservoir
        end
      end      
    end 
  end

  def get_delta(reservoir)
    delta = (100*reservoir["income"]/reservoir["baseAvailable"]).round(2)
    if delta.abs > 0.0001
      delta.to_s + " %"
    else
      "Not enough data"
    end
  end

  def get_percentage(data)
    return data.scan(/\d+\.\d+/).first.to_f
  end

end

# https://gist.github.com/poc7667/12aa2c8355871816114a