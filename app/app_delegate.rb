class AppDelegate < PM::Delegate
  # status_bar true, animation: :none
  include CDQ
  def on_load(app, options)
    cdq.setup
    return true if RUBYMOTION_ENV == "test"
    # open HomeScreen.new(nav_bar: true)
    # @menu = open MenuDrawer
    open_tab_bar ReservoirsScreen.new(nav_bar: true), HelpScreen.new(nav_bar: true)
  end

end
