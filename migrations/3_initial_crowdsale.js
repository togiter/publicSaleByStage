const ERC20Token = artifacts.require("ERC20Token");
const Cowdsale = artifacts.require('Crowdsale');

module.exports = function(deployer) {
  deployer.deploy(ERC20Token,"XINGLAN Token 1.0","fic",8).then(function(){
    //    let now = Math.floor(new Date().getTime()/1000);// 1562247449;//Math.floor(Date.now/1000);
    //    let startTime = now + 60; //60秒后
    //    //受益人
    //    let beneficiary = '0x18ed7cdc98d2bc8c21449765c8561e77ac71b8c5';
    //    let totalEtherCap = 10000;//众筹目标 eth
    //    console.log(FileCloud.address,startTime);
        return deployer.deploy(Cowdsale,ERC20Token.address);
  });
};