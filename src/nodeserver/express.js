/**
 * serveur express qui récupère la requête post envoyé par l'utilisateur 
 * depuis l'IHM angular. Les paramètres de la requête permettent de lancer un script et de renvoyer les COMTRADES demandées
 */

var express = require("express");

var bodyParser = require("body-parser");

var cors = require('cors')

var app = express();

/**
 * excution de scripts
 */
const shell = require('shelljs')
/** 
 * autoriser toutes les requêtes CORS
 */
app.use(cors())
/**
 * utiliser bodyParser comme middleware pour gérer les POST
 */
app.use(bodyParser.urlencoded({ extended:false}));
app.use(bodyParser.json());

app.get('/',function(req,res){
    res.send("leserveurfonctionne");
})

app.post('/requests.json',function(req,res){
    
    /**
     * boucle sur le nombre de requete
     * le script est lancé pour chaque requete
     * 4 parametres sont envoyés au script.sh : date/timeDebut et date/timeFin
     */
    for( var i = 0; i<Object.keys(req.body).length;i++){
        date = req.body[i].date;
        id = req.body[i].id;
        
        if (date.day<10){
            date.day = "0"+date.day
        }
        if(date.month<10){
            date.month = "O"+date.month
        }
        if(req.body[i].timeDebut.minute<10){
            req.body[i].timeDebut.minute="0"+req.body[i].timeDebut.minute
        }
        if(req.body[i].timeDebut.hour<10){
            req.body[i].timeDebut.hour="0"+req.body[i].timeDebut.hour
        }
        if(req.body[i].timeDebut.second<10){
            req.body[i].timeDebut.second="0"+req.body[i].timeDebut.second
        }
        if(req.body[i].timeFin.minute<10){
            req.body[i].timeFin.minute="0"+req.body[i].timeFin.minute
        }
        if(req.body[i].timeFin.hour<10){
            req.body[i].timeFin.hour="0"+req.body[i].timeFin.hour
        }
        if(req.body[i].timeFin.second<10){
            req.body[i].timeFin.second="0"+req.body[i].timeFin.second
        }

        timeDebut = req.body[i].timeDebut;
        timeFin = req.body[i].timeFin;
        
        startDate = date.month+"-"+date.day;
        startTime = timeDebut.hour+":"+timeDebut.minute
        startSecond = timeDebut.second;

        endDate = startDate;
        endTime = timeFin.hour+":"+timeFin.minute
        endSecond = timeFin.second;

        /**
         * attention vérifier que le script bien les droits nécessaires
         * pour être exécuter
         */
        script = "./express.sh"+" " + startDate +" "+startTime+" "+startSecond+" "+endDate+" "+endTime+" "+endSecond
        shell.exec(script,(error)=>{
            console.log(id)
                res.send({id:id,
                    reponse :"le fichier: "+ date.year+"-"+startDate+" "+startTime+":"+startSecond+
                " "+date.year+"-"+endDate+" "+endTime+":"+endSecond+".pcap est disponible sur le serveur ftp"});
                })
            
    }
    
    

    //res.end();  
})

app.listen(3000,function(){
    console.log("server demarre sur port 3000")
})
