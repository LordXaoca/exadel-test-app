package com.exadel.test.views {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class PreloaderView extends Sprite {

		private var _overlay : Overlay;
		private var _label : TextField;

		public function PreloaderView() {
			mouseChildren = false;
			initOverlay();
			initProgressField();
		}

		public function destroy() : void {
			if (_overlay) {
				_overlay.removeEventListener(Event.CHANGE, onOverlayChange);
				_overlay.destroy();
				_overlay = null;
			}

			_label = null;

			if (parent) {
				parent.removeChild(this);
			}
		}

		private function initOverlay() : void {
			_overlay = new Overlay();
			_overlay.addEventListener(Event.CHANGE, onOverlayChange);
			addChild(_overlay);
		}

		private function initProgressField() : void {
			Font.registerFont(TrebuchetMSFont);

			var format : TextFormat = new TextFormat();
			format.color = 0xFFFFFF;
			format.size = 16;
			format.font = "Trebuchet MS";

			_label = new TextField();
			_label.selectable = false;
			_label.antiAliasType = AntiAliasType.ADVANCED;
			_label.embedFonts = true;
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.alpha = 0.4;
			_label.defaultTextFormat = format;
			_label.text = "Loading...";
			addChild(_label);
		}

		private function onOverlayChange(event : Event) : void {
			_label.x = _overlay.width - _label.width >> 1;
			_label.y = _overlay.height - _label.height >> 1;
		}
	}
}
