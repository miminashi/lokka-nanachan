module Lokka
  module NanachanHeaderArea
    def self.registered(app)
      app.get '/admin/plugins/nanachan_header_area' do
        haml :"plugin/lokka-nanachan_header_area/views/index", :layout => :"admin/layout"
      end

      app.post '/admin/plugins/nanachan_header_area' do
        params.each_pair do |key, value|
          p "Option.#{key}='#{value}'"
          eval("Option.#{key}='#{value}'") if key != '_method'
        end 
        flash[:notice] = t.nanachan_header_area_updated
        redirect '/admin/plugins/nanachan_header_area'
      end
    end
  end

  module Helpers
    def nanachan_header_area
      code = ERB.new(Option.nanachan_header_area_inner_html).result(binding)
    end
  end
end
