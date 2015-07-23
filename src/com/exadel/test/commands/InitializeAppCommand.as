package com.exadel.test.commands {
	import com.exadel.test.GalleryEvent;

	import eu.alebianco.robotlegs.utils.impl.SequenceMacro;
	import eu.alebianco.robotlegs.utils.impl.SubCommandPayload;

	import flash.events.Event;

	public class InitializeAppCommand extends SequenceMacro {

		override public function prepare() : void {
//			add(DispatchEventCommand).withPayloads(new SubCommandPayload(new GalleryEvent(GalleryEvent.SHOW_PRELOADER), Event));
			add(LoadAssetsListCommand);
			add(LoadAssetsCommand);
			add(DispatchEventCommand).withPayloads(new SubCommandPayload(new GalleryEvent(GalleryEvent.ASSETS_LOADED), Event));
			add(DispatchEventCommand).withPayloads(new SubCommandPayload(new GalleryEvent(GalleryEvent.HIDE_PRELOADER), Event));
		}
	}
}
