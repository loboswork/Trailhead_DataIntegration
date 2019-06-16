@isTest
public class ProjectCalloutServiceMockFailure implements HttpCalloutMock {
   //Implement http mock callout failure here 
    public HttpResponse respond(HttpRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(400);
        res.setStatus('Bad Request');
        return res;
    }
}