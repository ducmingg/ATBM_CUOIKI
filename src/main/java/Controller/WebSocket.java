package Controller;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/events")
public class WebSocket {
    @OnOpen
    public void onOpen(Session session){
        System.out.println("New connection: "+session.getId());
    }

    @OnMessage
    public String onMessage(String msg, Session session) {
        return "Received: "+ msg;
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("Connection closed: " + session.getId());
    }


}
