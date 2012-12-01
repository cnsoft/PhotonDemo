package photon 
{
	import de.exitgames.photon_as3.loadBalancing.LoadBalancedPeer;
	
	import flash.utils.Dictionary;

	/**
	 * @author stoppi
	 */
	public class PhotonPeer extends LoadBalancedPeer 
	{
		public static function getInstance():LoadBalancedPeer
        {
            if (_instance == null)
            {
                _instance = new PhotonPeer();
            }
			
			_instance.doDebug = false;
            
			return _instance;
        }
		
		public function PhotonPeer() 
		{
			_instance = this;
		}
		
		override protected function parseEventDataGame(eventCode:int, data:Dictionary):void
        {
            // parse event from gameserver

            switch (eventCode)
            {
				case GameConstants.EV_SENDPOS:
				case GameConstants.EV_FIRED:
				case GameConstants.EV_DEAD:
                {
                    var actorEvent:ActorEvent = ActorEvent.create(eventCode, data);
                    
                    dispatchEvent(actorEvent);
                    break;
                }
				
				default:
                {
                    super.parseEventDataGame(eventCode, data);
                    break;
                }
            }
        }
	}
}
