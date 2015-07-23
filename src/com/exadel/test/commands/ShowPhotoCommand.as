package com.exadel.test.commands {
	import com.exadel.test.GalleryEvent;

	import eu.alebianco.robotlegs.utils.impl.SequenceMacro;
	import eu.alebianco.robotlegs.utils.impl.SubCommandPayload;

	import flash.events.Event;

	public class ShowPhotoCommand extends SequenceMacro {

		[Inject]
		public var event : GalleryEvent;

		override public function prepare() : void {
//			add(DispatchEventCommand).withPayloads(new SubCommandPayload(new GalleryEvent(GalleryEvent.SHOW_PRELOADER), Event));
			add(LoadPhotoCommand).withPayloads(new SubCommandPayload(event.data.photoPath, String).withName("imageURL"));
//			add(DispatchEventCommand).withPayloads(new SubCommandPayload(new GalleryEvent(GalleryEvent.HIDE_PRELOADER), Event));
			add(DispatchEventCommand).withPayloads(new SubCommandPayload(new GalleryEvent(GalleryEvent.SHOW_PHOTO, event.data), Event));
		}
	}
}
