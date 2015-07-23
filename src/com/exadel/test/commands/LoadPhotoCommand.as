package com.exadel.test.commands {
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.IAssetsLoader;

	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	public class LoadPhotoCommand extends AsyncCommand {

		[Inject(name="imageURL")]
		public var url : String;

		[Inject]
		public var loader : IAssetsLoader;

		override public function execute() : void {
			super.execute();

			loader.addEventListener(BulkProgressEvent.COMPLETE, onLoad);
			loader.add(url);
			loader.start();
		}

		override protected function dispatchComplete(success : Boolean) : void {
			loader.removeEventListener(BulkProgressEvent.COMPLETE, onLoad);

			super.dispatchComplete(success);
		}

		private function onLoad(event : BulkProgressEvent) : void {
			dispatchComplete(true);
		}
	}
}
