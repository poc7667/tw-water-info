class HomeLayout < MK::Layout
  view :reservoirs_view
  def layout
    root :main do
      add reservoirs_view, :reservoirs
    end
  end

end  