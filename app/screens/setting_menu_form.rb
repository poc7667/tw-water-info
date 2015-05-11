class SettingMenuForm < PM::FormotionScreen

  def on_load
    # nav_bar_title = site.nil? ? 'Save': 'Update'
    set_nav_bar_button :right, title: 'Save', action: :save
    set_nav_bar_button :left,  title: 'Back',      action: :back
  end



  def table_data
    {
      sections: [
        {
          title: "site",
          rows: [
            {
              title:       "Title",
              key:         :title,
              type:        :string,
              placeholder: "text here",
              value:       13
            },
            {
              title:       "URL",
              key:         :url,
              type:        :string,
              placeholder: "text here",
              value:       45
            }
          ]
        }
      ]
    }
  end

  private

    def back
      close
    end

    def save
      
    end



end
