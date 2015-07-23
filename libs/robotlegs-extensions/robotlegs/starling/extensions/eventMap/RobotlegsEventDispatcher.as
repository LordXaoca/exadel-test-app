package robotlegs.starling.extensions.eventMap {
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.extensions.localEventMap.api.IEventMap;

	public class RobotlegsEventDispatcher {

		[Inject]
		public var eventMap : IEventMap;

		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[PreDestroy]
		public function destroy() : void {
			eventMap.unmapListeners();
			eventMap = null;

			eventDispatcher = null;
			trace("\t\t\t>> destroy:", this);
		}

		protected function addContextListener(eventString : String, listener : Function, eventClass : Class = null) : void {
			eventMap.mapListener(eventDispatcher, eventString, listener, eventClass);
		}

		protected function removeContextListener(eventString : String, listener : Function, eventClass : Class = null) : void {
			eventMap.unmapListener(eventDispatcher, eventString, listener, eventClass);
		}

		protected function dispatch(event : Event) : void {
			if (eventDispatcher.hasEventListener(event.type)) {
				eventDispatcher.dispatchEvent(event);
			}
		}
	}
}
