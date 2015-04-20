class HomeLayout < MK::Layout
  view :reservoirs_view
  def layout
    root :main do
      add reservoirs_view, :reservoirs
    end
  end

  def main_style
    background_color "#F9F9F9".uicolor
  end

end  