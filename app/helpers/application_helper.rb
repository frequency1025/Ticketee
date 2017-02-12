module ApplicationHelper
	
	def titlemethod(*parts)
		unless parts.empty?
			content_for :titlesym do
				(parts << "Ticketee").join(" - ")
			end
		end
	end

	def admins_only(&block)
		block.call if current_user.try(:admin?)
	end


end
