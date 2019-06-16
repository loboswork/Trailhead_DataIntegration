@isTest
public class ProjectCalloutServiceMock implements HttpCalloutMock{
   //Implement http mock callout here
    public HttpResponse respond(HttpRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status":"Created"}');
        res.setStatusCode(201);
        return res;
    }
}