class Api::EventsController < ApplicationController
  protect_from_forgery with: :null_session
	respond_to :json

	def determine_schedule
		if params[:allotments]
			allotments = params[:allotments]
			allotments.sort_by! { |x| x['start'] }
			width = 620
			
			coords = []
			events = []
			allotments.each_with_index do |e, i|
				ec = e.clone
				col = 0
				while (col < events.length && ec['start'] < events[col].last['end'])
					col += 1
				end
				if col == events.length
					total_cols = col + 1
					ec['left'] = col * (width / total_cols)
					ec['top'] = ec['start']
					ec['width'] = width / total_cols
					ec['height'] = ec['end'] - ec['start']
					ec['col'] = col
					ec['span'] = 1
					events.push([ec])
				else
					ec['left'] = col * (width / events.length)
					ec['top'] = ec['start']
					ec['height'] = ec['end'] - ec['start']
					max_available_col = col + 1
					while (max_available_col < events.length && ec['start'] >= events[max_available_col].last['end'])
						max_available_col += 1
					end
					ec['col'] = col
					ec['span'] = max_available_col - col
					ec['width'] = (width / events.length) * ec['span']
					events[col].push(ec)
				end
				update_width(events, ec, col, width)
			end
			events.flatten!
			events.sort_by! { |x| x['start'] }
			render json: events
		else
			render json: {success: false}, status: :bad_request
		end
	end

	def update_width(events, cur, col, width)
		if (col > 0) 
			for i in 0..col - 1
				for j in 0..events[col - i - 1].length - 1
					if events[col - i - 1][j]['span'] == (i + 1) && (events[col - i - 1][j]['end'] > cur['start'] || events[col - i - 1][j]['start'] < cur['end'])
						events[col - i - 1][j]['left'] = events[col - i - 1][j]['col'] * (width / events.length)
						events[col - i - 1][j]['width'] = events[col - i - 1][j]['span'] * (width / events.length)
						update_width(events, events[col - i - 1][j], col - i - 1, width)
					end
				end
			end
		end
	end
end
