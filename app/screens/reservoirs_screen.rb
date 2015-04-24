class ReservoirsScreen < PM::TableScreen
  refreshable callback: :on_refresh
  searchable
  longpressable
  title "台灣水庫資訊"

  def on_init
    set_nav_bar_button :right, title: "Help", action: :show_help
    set_tab_bar_item title: "水庫資訊", item: "tabs_icon/show-all.png"
  end

  def on_load
    $returned_data = [{title: 'nil'}]
    on_refresh
  end

  def on_refresh
    start_refreshing
    get_reserviors
    update_table_data
    stop_refreshing
  end  

  def table_data
    [{
        cells: $returned_data.map do |reservoir|
          {
            title: reservoir["title"],
            subtitle: reservoir["subtitle"],
            # editing_style: :insert,
            long_press_action: :show_menu,
            editing_style: :delete,
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

  def show_menu
      UIAlertView.alert('加入關注列表',
        # message: 'Don\'t worry, it\'ll be fine.',
        buttons: ['OK', 'Cancel'],
        ) do |button, button_index|
        if button == 'OK'  # or: button_index == 1
          print "you pressed OK"
        elsif button == "Cancel"
            print "nevermind"
        end
      end
  end

  def on_cell_deleted(cell)
      # PM::logger(cell)
      p cell[:arguments]
      # matrixToDel=Matrix.where(:matrix_image).eq(cell[:arguments][:matrix_image])
      # matrixToDel.first.destroy
      # cdq.save
      true
  end
  def long_press_action(cell)
      PM::logger.info(cell)
      # App.delegate.slide_menu.show_menu    
  end


  def select_reservoir(reservoir)
    PM.logger.info reservoir
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
        update_table_data
      end      
    end 
  end

  def get_delta(reservoir)
    delta = (100*reservoir["income"]/reservoir["baseAvailable"]).round(2)
    if delta.abs > 0.0001
      return delta.to_s + " %"
    else
      return  "Not enough data"
    end
  end

  def get_percentage(data)
    return data.scan(/\d+\.\d+/).first.to_f
  end

end