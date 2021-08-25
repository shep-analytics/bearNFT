const { assert, expect } = require("chai");
// const {expectRevert} = require('@openzeppelin/test-helpers');

const Bear = artifacts.require("Bear");

const Web3  = require("web3")



require("chai")
.use(require("chai-as-promised"))
.should()

contract("Bear", ([deployer,investor]) => {
    
    let bear;
    let web3;
    
    beforeEach(async ()=>{
        bear = await Bear.new();
        web3 = new Web3('http://localhost:7545');
    })


    describe('Bear',()=>{
        it('Transaction Test', async ()=>{
            console.log(investor)

            console.log(await bear.claim('test7',investor,{from:deployer,value: web3.utils.toWei('0.01', 'ether')}))

        })
    })

   
})
