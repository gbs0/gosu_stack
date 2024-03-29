require 'gosu'

def media_path(file) # Add file path
	File.join(File.dirname(File.dirname(
		__FILE__)), 'media', file)
end

class Explosion # Class for Explosion Asset
	FRAME_DELAY = 10 # 10ms
	SPRITE = media_path('boom.png') # Our explosion Asset

	def self.load_animation(window)
		Gosu::Image.load_tiles(
			window, SPRITE, 128, 128, false)
	end

	def initialize(animation, x, y)
		@animation = animation
		@x, @y = x, y
		@current_frame = 0
	end

	def update
		@current_frame += 1 if frame_expired?
	end

	def draw
		return if done?
		image = current_frame
		image.draw(
			@x - image.width / 2.0,
			@y - image.height / 2.0,
			0)
	end

	def done?
		@done ||= @current_frame == @animation.size
	end

end

	private

	def current_frame
		@animation[@current_frame % @animation.size]
	end

	def frame_expired?
		now = Gosu.milliseconds
		@last_frame ||= now
		if (now - @last_frame) > FRAME_DELAY
			@last_frame = now
		end
	end
end

class GameWindow < Gosu::Window
end

window = GameWindow.new
window.show