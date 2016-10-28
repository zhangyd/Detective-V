module IssuesHelper
	def class_for_severity(severity)
		color_map = {
			0 => 'info', 
			1 => 'info',
			2 => 'warning',
			3 => 'warning',
			4 => 'warning',
			5 => 'danger',
			6 => 'danger',
			7 => 'danger'
		}
		return color_map[severity]
	end
end
