class HomeScreen < PM::Screen
  title "台灣水情資訊"

  def on_load
    # set_nav_bar_button :right, title: "Help", action: :show_help
    @layout = HomeLayout.new(root: self.view)
    @layout.reservoirs_view = reservoirs_screen.view
    @layout.build
  end

  def reservoirs_screen
    @reservoirs_screen ||= begin
      m = ReservoirsScreen.new
      self.addChildViewController m
      m.parent_screen = self # Automatically a weak reference
      m
    end
  end

end
