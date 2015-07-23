package com.exadel.test {
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.IAssetsLoader;
	import br.com.stimuli.loading.IAssetsManager;

	import com.exadel.test.commands.InitializeAppCommand;
	import com.exadel.test.commands.ShowPhotoCommand;
	import com.exadel.test.models.AppModel;
	import com.exadel.test.views.GalleryMediator;
	import com.exadel.test.views.GalleryView;
	import com.exadel.test.views.ImagePreviewMediator;
	import com.exadel.test.views.ImagePreviewView;
	import com.exadel.test.views.ImageViewerMediator;
	import com.exadel.test.views.ImageViewerView;

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;

	public class GalleryConfig implements IConfig {

		[Inject]
		public var commandMap : IEventCommandMap;
		[Inject]
		public var mediatorMap : IMediatorMap;
		[Inject]
		public var injector : IInjector;
		[Inject]
		public var context : IContext;
		[Inject]
		public var dispatcher : IEventDispatcher;

		public function configure() : void {
			mapInjections();
			mapMediators();
			mapCommands();
		}

		private function mapInjections() : void {
			injector.map(AppModel).asSingleton();

			var loader : BulkLoader = new BulkLoader("default");
			injector.map(IAssetsLoader).toValue(loader);
			injector.map(IAssetsManager).toValue(loader);
		}

		private function mapMediators() : void {
			mediatorMap.map(GalleryView).toMediator(GalleryMediator);
			mediatorMap.map(ImagePreviewView).toMediator(ImagePreviewMediator);
			mediatorMap.map(ImageViewerView).toMediator(ImageViewerMediator);
		}

		private function mapCommands() : void {
			commandMap.map(Event.INIT).toCommand(InitializeAppCommand).once();
			commandMap.map(GalleryEvent.LOAD_PHOTO).toCommand(ShowPhotoCommand);
		}
	}
}
