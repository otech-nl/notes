// https://mooz.github.io/org-js/
var url = new URL(location.href);
var page = url.searchParams.get("page") || "index.org";

function fixLinks(doc) {
    console.log(doc)
    if((doc.type === "link")) {
        console.log(doc.type.link)
    }
    doc.children && doc.children.map(fixLinks)
}

var content = new XMLHttpRequest();
content.onreadystatechange = function(){
    if( (content.readyState === 4) && (content.status === 200 || content.status === 0)) {
        var orgParser = new Org.Parser();
        var orgDocument = orgParser.parse(content.responseText);
        fixLinks(orgDocument)
        var orgHTMLDocument = orgDocument.convert(Org.ConverterHTML);
        document.getElementById('root').innerHTML = orgHTMLDocument.toString()
    } else {
        console.log('Error', content)
    }
};
content.open("GET", "/org/" + page, true);
content.send(null);
