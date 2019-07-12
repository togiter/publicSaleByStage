<template>
    <div class="crowdsale">
     <el-form >
         <el-form-item label="Eths">
                <el-input v-model="ether" placeholder="输入以太坊数量(ether)"></el-input><el-button @click = "ethClicked">发送</el-button>
            </el-form-item> 
             <el-form-item label="设置以太坊价格(¥)">
                <el-input v-model="etherPrice" placeholder="输入以太坊价格(¥)"></el-input><el-button @click = "setupEthPrice">设置</el-button>
            </el-form-item> 
             <el-form-item label="余额">
                 <el-input v-model="balanceAddr" placeholder="balance"></el-input><el-button @click = "balanceClicked">余额</el-button> 
             </el-form-item>
              <el-form-item label="转账">
                 <el-input v-model="amount" placeholder="转账金额"></el-input>
                 <el-input v-model="addr" placeholder="地址"></el-input>
                 <el-button @click = "transferClicked">开始转账</el-button> 
             </el-form-item>
     </el-form>
    </div>
</template>

<script>
import {web3ContributeETH,web3SetEtherPrice} from "@/web3js/crowdsale/crowdsale.js";
import {web3Transfer,web3Balance} from "@/web3js/smarttoken/smarttoken.js";
export default {
    data() {
        return {
            ether:'',
            startTimeStamp:'',
            balanceAddr:'',
            amount:'',
            addr:'',
            etherPrice:'',
            
        }
    },
    created() {
    //   window.web3.eth.getBalance('0x8E577e3D264308f573e4c31551053a960003F196').then(ret=>{
    //       console.log('contrct Addr:',ret);
    //   });
      
    },
    methods: {

        setupEthPrice(){
            web3SetEtherPrice(Number.parseInt(this.etherPrice));
        },
        ethClicked(){
            web3ContributeETH(this.ether*Math.pow(10,18));
        },
        balanceClicked(){
            console.log('balc');
            web3Balance(this.balanceAddr);
        },
        transferClicked(){
            console.log('transfer');
             web3Transfer(this.addr,this.amount);
        }
    },
}
</script>
<style>

</style>


