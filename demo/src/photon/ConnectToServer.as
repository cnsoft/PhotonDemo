package photon 
{
	import com.junkbyte.console.Cc;
	
	import de.exitgames.photon_as3.events.*;
	import de.exitgames.photon_as3.loadBalancing.LoadBalancedPeer;
	import de.exitgames.photon_as3.loadBalancing.model.constants.ErrorCodes;
	import de.exitgames.photon_as3.loadBalancing.model.event.*;
	import de.exitgames.photon_as3.loadBalancing.model.response.*;
	import de.exitgames.photon_as3.loadBalancing.model.vo.ActorProperties;
	import de.exitgames.photon_as3.loadBalancing.model.vo.GameProperties;
	import de.exitgames.photon_as3.response.*;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import photon.PhotonPeer;
	
	public class ConnectToServer 
	{
		private var _peer:LoadBalancedPeer;
		
		function ConnectToServer() 
		{
			setupphoton();
		}
		
		private function setupphoton():void
        {
            _peer = PhotonPeer.getInstance();
            _peer.showDetailedTraceInfos(false);

            // mirror custom events, so that the event flow for the chat is the same for local and remote peers
    //        _peer.setMirrorCustomEvents(true);

            // listen for standard photon responses and events
            addphotonListeners();

            // listen for the steps of the loadbalancing flow
            addLoadBalancingListeners();

            // listen for errors
            addErrorListeners();
        }
		
		public function connect():void
		{
			var server:String = "app.exitgamescloud.com";
            var port:int = 4530;
            var policyPort:int = 843;
            var applicationId:String = "279173f6-e770-434a-94c7-bcdbd2cc472a";
            var applicationVersion:String = "v1.0";
			
			_peer.establishBalancedConnection(server, port, policyPort, applicationId, applicationVersion);
		}
		
		private function onConnectedToGame(event:LoadBalancingStateEvent):void
        {
            Cc.log("=== APP onConnectedToGame: " + event.toString() + " ===");
        }
		
		private function onGameListReceived(evt:GameListEvent):void
		{
			_peer.removeEventListener(GameListEvent.TYPE, onGameListReceived);
			
			if (_peer.getNumberOfGames() == 0)
			{
				var id:String = "myGame_0";
			
				var gp:GameProperties = GameProperties.createDefault();
				
				_peer.opCreateGame(id, gp);
			}
			else
			{
				_peer.opJoinGame("myGame_0");
			}
		}

        private function onConnectedToMaster(event:LoadBalancingStateEvent):void
        {
            Cc.log("=== APP onConnectedToMaster: " + event.toString() + " ===");
			
			Cc.warn("number of games ", _peer.getNumberOfGames());
			
			var ap : ActorProperties = _peer.getLocalActorProperties();

			ap = ActorProperties.createDefault();
			ap.actorName = "Actor_" + Math.ceil(Math.random()*1000);
			Cc.log("generated ActorProperties, actor name: " + ap.actorName);
			_peer.setLocalActorProperties(ap);		
			
			_peer.addEventListener(GameListEvent.TYPE, onGameListReceived);
        }

        private function onConnectingToGame(event:LoadBalancingStateEvent):void
        {
            Cc.log("=== APP onConnectingToGame: " + event.toString() + " ===");
        }

        private function onConnectingToMaster(event:LoadBalancingStateEvent):void
        {
            Cc.log("=== APP onConnectingToMaster: " + event.toString() + " ===");
        }

        private function onDisconnectedFromGame(event:LoadBalancingStateEvent):void
        {
            Cc.log("=== APP onDisconnectedFromGame: " + event.toString() + " ===");
        }

        private function onDisconnectedFromMaster(event:LoadBalancingStateEvent):void
        {
            Cc.log("=== APP onDisconnectedFromMaster: " + event.toString() + " ===");
        }

        private function onDisconnectingFromGame(event:LoadBalancingStateEvent):void
        {
            Cc.log("=== APP onDisconnectingFromGame: " + event.toString() + " ===");
        }

        private function onDisconnectingFromMaster(event:LoadBalancingStateEvent):void
        {
            Cc.log("=== APP onDisconnectingFromMaster: " + event.toString() + " ===");
        }

        /**
         * state event handlers
         * used in this example to attach different screen controllers
         */

        private function onLoadBalancingInit(event:LoadBalancingStateEvent):void
        {
            Cc.log("=== APP onLoadBalancingInit: " + event.toString() + " ===");
        }

        /**
         * handles all errors dispatched by photon
         *
         * @param event
         */
        private function onphotonError(event:Event):void
        {
            Cc.log("### photon ERROR ###");
            Cc.log(event.toString());
			
            switch (event.type)
            {

                case IOErrorEvent.IO_ERROR:
                {
                    Cc.log("IO_ERROR: Connection to server failed!");
                    break;
                }

                case SecurityErrorEvent.SECURITY_ERROR:
                {
                    Cc.log("SECURITY_ERROR: Could not read security policy file!");
                    break;
                }

                case PhotonErrorEvent.ERROR:
                {
                    if (PhotonErrorEvent(event).getCode() == ErrorCodes.NO_RANDOM_MATCH_FOUND) 
					{
						Cc.log(PhotonErrorEvent(event).getCode());
					}
					else
					{
						Cc.log("ERROR code=" + PhotonErrorEvent(event).getCode().toString() + ", message=" + PhotonErrorEvent(event).getMessage());
					}
					break;
                }

                default:
                    break;
            }
        }
		
		/**
         * handles all the events dispatched by photon
         *
         * @param event
         */
        private function onphotonEvent(event:Event):void
        {
            Cc.log("app onphotonEvent: type of event: " + event.type);

            switch (event.type)
            {

                case Event.CLOSE:
                {
                    Cc.log("!!!connection to server closed!!!");
                    Cc.log("Connection to the server closed!");
                    break;
                }

                case LeaveEvent.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Event: leave!");
                    Cc.log("=> actor who left:" + (event as LeaveEvent).getActorNo());
                    Cc.log("=> " + (event as LeaveEvent).getActorNumbers().length + " actors in room:" + (event as LeaveEvent).getActorNumbers().join(", "));
                    break;
                }

                case AppStatsEvent.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Event: AppStats");
                    Cc.log("=> actor who sent message:" + (event as AppStatsEvent).getActorNo());
				    break;
                }

                case GameListEvent.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Event: gameList!");
                    Cc.log("=> gameList: " + (event as GameListEvent).getGameList());
                    break;
                }

                case GameListUpdateEvent.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Event: gameListUpdate!");
                    Cc.log("=> gameList: " + (event as GameListUpdateEvent).getGameList());
                    break;
                }
				
                default:
                {
                    var err:PhotonErrorEvent = new PhotonErrorEvent(PhotonErrorEvent.ERROR);
                    err.setMessage("received unknown event type " + event.type);
                    onphotonError(err);
                    break;
                }
            }
        }

        /**
         * handles all the responses dispatched by photon
         *
         * @param event
         */
        private function onphotonResponse(event:Event):void
        {
			switch (event.type)
            {
				case InitializeConnectionResponse.TYPE:
                {
                    Cc.log("got photon Response: initialize!");
                    break;
                }

                case JoinResponse.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Response: join! " + (event as JoinResponse).getReturnCode());
                    break;
                }

                case LeaveResponse.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Response: leave! " + (event as LeaveResponse).getReturnCode());
                    break;
                }

                case CreateGameResponse.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Response: createGame! " + (event as CreateGameResponse).getReturnCode());
                    break;
                }

                case JoinGameResponse.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Response: joinGame! " + (event as JoinGameResponse).getReturnCode());
                    break;
                }

                case JoinRandomGameResponse.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Response: joinRandomGame! " + (event as JoinRandomGameResponse).getReturnCode());
                    break;
                }

                case CustomResponse.TYPE:
                {
                    Cc.log("actor" + _peer.getActorNo() + " got photon Response: custom! " + (event as CustomResponse).getReturnCode());
                    break;
                }
            }
        }
		
		private function addErrorListeners():void
        {
            //listen for errors
            _peer.addEventListener(IOErrorEvent.IO_ERROR, onphotonError);
            _peer.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onphotonError);
            _peer.addEventListener(PhotonErrorEvent.ERROR, onphotonError);
        }

        private function addLoadBalancingListeners():void
        {
            // listen for state changes
            _peer.addEventListener(LoadBalancingStateEvent.INIT, onLoadBalancingInit);
            _peer.addEventListener(LoadBalancingStateEvent.CONNECTING_TO_MASTER, onConnectingToMaster);
            _peer.addEventListener(LoadBalancingStateEvent.CONNECTED_TO_MASTER, onConnectedToMaster);
            _peer.addEventListener(LoadBalancingStateEvent.DISCONNECTING_FROM_MASTER, onDisconnectingFromMaster);
            _peer.addEventListener(LoadBalancingStateEvent.DISCONNECTED_FROM_MASTER, onDisconnectedFromMaster);
            _peer.addEventListener(LoadBalancingStateEvent.CONNECTING_TO_GAME, onConnectingToGame);
            _peer.addEventListener(LoadBalancingStateEvent.CONNECTED_TO_GAME, onConnectedToGame);
            _peer.addEventListener(LoadBalancingStateEvent.DISCONNECTING_FROM_GAME, onDisconnectingFromGame);
            _peer.addEventListener(LoadBalancingStateEvent.DISCONNECTED_FROM_GAME, onDisconnectedFromGame);
        }

        private function addphotonListeners():void
        {
            //listen for photon responses
            _peer.addEventListener(InitializeConnectionResponse.TYPE, onphotonResponse);
            _peer.addEventListener(JoinResponse.TYPE, onphotonResponse);
            _peer.addEventListener(LeaveResponse.TYPE, onphotonResponse);
            _peer.addEventListener(CustomResponse.TYPE, onphotonResponse);
            _peer.addEventListener(Event.CLOSE, onphotonEvent);
            _peer.addEventListener(GameListEvent.TYPE, onphotonEvent);
            _peer.addEventListener(GameListUpdateEvent.TYPE, onphotonEvent);
            _peer.addEventListener(LeaveEvent.TYPE, onphotonEvent);
            _peer.addEventListener(AppStatsEvent.TYPE, onphotonEvent);
            _peer.addEventListener(CustomEvent.TYPE, onphotonEvent);
        }
	}
}