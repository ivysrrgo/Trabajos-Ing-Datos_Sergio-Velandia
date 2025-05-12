const mongoose=require('mongoose');

const itemSchema=new mongoose.Schema({
    Nombre:{type:String, require:true},
    Descripcion:String,
    Precio:{},
    Cantidad:{},
    creadoEn:{type:Date,default:Date.now}
});

module.exports=mongoose.model('Item',itemSchema)