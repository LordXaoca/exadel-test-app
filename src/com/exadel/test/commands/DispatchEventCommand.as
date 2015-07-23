package com.exadel.test.commands {
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.bundles.mvcs.Command;

	public class DispatchEventCommand extends Command {

		[Inject]
		public var dispatcher : IEventDispatcher;

		[Inject]
		public var event : Event;

		override public function execute() : void {
			super.execute();

			dispatcher.dispatchEvent(event);
		}
	}
}
