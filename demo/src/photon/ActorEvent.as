package photon 
{
	import de.exitgames.photon_as3.events.BasicEvent;
	import de.exitgames.photon_as3.loadBalancing.model.constants.Constants;

	import flash.utils.Dictionary;

	public class ActorEvent extends BasicEvent
    {
        public static const TYPE:String = "ActorEvent.TYPE";

        public static function create(eventCode:int, data:Dictionary):ActorEvent
        {
            var event:ActorEvent = new ActorEvent(data[Constants.KEY_ACTOR_NO], data[Constants.KEY_DATA]);
            event.setBasicValues(eventCode, data);
            return event;
        }
		
        public var message:Dictionary;
        
        public function ActorEvent(actorNo:int, msg:Dictionary)
        {
			super(TYPE);
            this.message = msg;
			setActorNo(actorNo);
        }
    }
}
