const p4db=db.getSiblingDB('connectsphere_p4_db');
print('BEFORE: public feed query explain');
printjson(p4db.posts.find({visibility:'public'}).sort({createdAt:-1}).limit(10).explain('executionStats'));
print('Creating compound index');
printjson(p4db.posts.createIndex({visibility:1,createdAt:-1},{name:'idx_visibility_created'}));
print('AFTER: same query explain');
printjson(p4db.posts.find({visibility:'public'}).sort({createdAt:-1}).limit(10).explain('executionStats'));
print('Index inventory');printjson(p4db.posts.getIndexes());
// Small datasets can show similar runtimes; compare winning plan and keys/docs examined.
