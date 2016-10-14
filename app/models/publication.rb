class Publication < ActiveRecord::Base

	auto_html_for :file_url do
		html_escape
    image
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
	end
end
