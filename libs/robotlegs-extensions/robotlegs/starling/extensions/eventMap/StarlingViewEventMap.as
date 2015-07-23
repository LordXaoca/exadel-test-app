//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.starling.extensions.eventMap
{
	import flash.events.Event;

	import starling.events.EventDispatcher;

	/**
	 * @private
	 */
	public class StarlingViewEventMap implements IStarlingViewEventMap
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _listeners:Vector.<StarlingEventMapConfig> = new Vector.<StarlingEventMapConfig>();

		private const _suspendedListeners:Vector.<StarlingEventMapConfig> = new Vector.<StarlingEventMapConfig>();

		private var _suspended:Boolean = false;

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function mapListener(dispatcher : EventDispatcher, type : String, listener : Function, eventClass : Class = null): void
		{
			eventClass ||= Event;

			const currentListeners:Vector.<StarlingEventMapConfig> = _suspended
					? _suspendedListeners
					: _listeners;

			var config:StarlingEventMapConfig;

			var i:int = currentListeners.length;
			while (i--)
			{
				config = currentListeners[i];
				if (config.equalTo(dispatcher, type, listener, eventClass))
				{
					return;
				}
			}

			const callback:Function = eventClass == Event
				? listener
				: function(event:Event):void
				{
					routeEventToListener(event, listener, eventClass);
				};

			config = new StarlingEventMapConfig(dispatcher,
				type,
				listener,
				eventClass,
				callback);

			currentListeners.push(config);

			if (!_suspended)
			{
				dispatcher.addEventListener(type, callback);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function unmapListener(dispatcher : EventDispatcher, type : String, listener : Function, eventClass : Class = null): void
		{
			eventClass ||= Event;

			const currentListeners:Vector.<StarlingEventMapConfig> = _suspended
				? _suspendedListeners
				: _listeners;

			var i:int = currentListeners.length;
			while (i--)
			{
				var config:StarlingEventMapConfig = currentListeners[i];
				if (config.equalTo(dispatcher, type, listener, eventClass))
				{
					if (!_suspended)
					{
						dispatcher.removeEventListener(type, config.callback);
					}
					currentListeners.splice(i, 1);
					return;
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function unmapListeners():void
		{
			const currentListeners:Vector.<StarlingEventMapConfig> = _suspended ? _suspendedListeners : _listeners;

			var eventConfig:StarlingEventMapConfig;
			var dispatcher:EventDispatcher;
			while (eventConfig = currentListeners.pop())
			{
				if (!_suspended)
				{
					dispatcher = eventConfig.dispatcher;
					dispatcher.removeEventListener(eventConfig.eventString, eventConfig.callback);
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function suspend():void
		{
			if (_suspended)
				return;

			_suspended = true;

			var eventConfig:StarlingEventMapConfig;
			var dispatcher:EventDispatcher;
			while (eventConfig = _listeners.pop())
			{
				dispatcher = eventConfig.dispatcher;
				dispatcher.removeEventListener(eventConfig.eventString, eventConfig.callback);
				_suspendedListeners.push(eventConfig);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function resume():void
		{
			if (!_suspended)
				return;

			_suspended = false;

			var eventConfig:StarlingEventMapConfig;
			var dispatcher:EventDispatcher;
			while (eventConfig = _suspendedListeners.pop())
			{
				dispatcher = eventConfig.dispatcher;
				dispatcher.addEventListener(eventConfig.eventString, eventConfig.callback);
				_listeners.push(eventConfig);
			}
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * Event Handler
		 *
		 * @param event The <code>Event</code>
		 * @param listener
		 * @param originalEventClass
		 */
		protected function routeEventToListener(event:Event, listener:Function, originalEventClass:Class):void
		{
			if (event is originalEventClass)
			{
				if (listener.length != 0)
				{
					listener(event);
				} else {
					listener();
				}
			}
		}
	}
}
