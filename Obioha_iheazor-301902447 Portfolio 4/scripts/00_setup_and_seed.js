// Run in mongosh: load("scripts/00_setup_and_seed.js") from the portfolio folder.
// WARNING: replaces ONLY the named ConnectSphere P4 collections in connectsphere_p4_db.
const p4db = db.getSiblingDB('connectsphere_p4_db');
['users','posts','activity_events'].forEach(n => p4db.getCollection(n).drop());
p4db.createCollection('users', {validator: {$jsonSchema:{bsonType:'object',required:['username','email','createdAt'],properties:{username:{bsonType:'string'},email:{bsonType:'string'},createdAt:{bsonType:'date'}}}}});
p4db.createCollection('posts', {validator: {$jsonSchema:{bsonType:'object',required:['authorId','content','createdAt','comments','likedBy'],properties:{authorId:{bsonType:'objectId'},content:{bsonType:'string'},createdAt:{bsonType:'date'},comments:{bsonType:'array'},likedBy:{bsonType:'array'}}}}});
p4db.createCollection('activity_events');
const base=new Date('2026-01-01T00:00:00Z');
const users=Array.from({length:100},(_,i)=>({username:`p4_user_${String(i+1).padStart(3,'0')}`,email:`p4_user_${i+1}@example.test`,createdAt:base}));
p4db.users.insertMany(users);
const ids=p4db.users.find({}, {_id:1}).sort({username:1}).toArray().map(x=>x._id);
const posts=Array.from({length:500},(_,i)=>({authorId:ids[i%100],content:`ConnectSphere synthetic post ${i+1} about database modelling`,visibility:i%5===0?'followers':'public',createdAt:new Date(base.getTime()+i*60000),comments:Array.from({length:i%4},(_,j)=>({commentId:new ObjectId(),authorId:ids[(i+j+3)%100],content:`Comment ${j+1} on post ${i+1}`,createdAt:new Date(base.getTime()+i*60000+(j+1)*1000)})),likedBy:Array.from({length:i%8},(_,j)=>ids[(i+j+7)%100])}));
p4db.posts.insertMany(posts);
const events=Array.from({length:200},(_,i)=>({actorId:ids[i%100],type:i%2===0?'view':'share',targetType:'post',occurredAt:new Date(base.getTime()+i*30000),metadata:{source:i%2===0?'feed':'profile',device:i%3===0?'mobile':'desktop'}}));
p4db.activity_events.insertMany(events);
printjson({database:p4db.getName(),users:p4db.users.countDocuments({}),posts:p4db.posts.countDocuments({}),activity_events:p4db.activity_events.countDocuments({}),embedded_comments:p4db.posts.aggregate([{$unwind:'$comments'},{$count:'n'}]).toArray()[0]?.n||0});
