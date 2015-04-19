class HomeScreen < PM::Screen
  title "台灣水情資訊"

  def on_load
    set_nav_bar_button :right, title: "Help", action: :show_help
    @layout = HomeLayout.new(root: self.view).build
  end

  def show_help
    open HelpScreen
  end

end
