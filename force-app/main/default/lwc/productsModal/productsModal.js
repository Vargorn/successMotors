import { LightningElement, api, track } from 'lwc';
import getOpportunityProducts from '@salesforce/apex/ProductsModalController.getOpportunityProducts';

export default class ProductsModal extends LightningElement {

    @track products = [];
    @api oppid;
    @api isModalOpen;

    get oppProducts() {
        return this.products;
    }

    async connectedCallback() {
        this.products = await getOpportunityProducts( { oppId : this.oppid} );
    }

    handlerCloseModal() {
        this.isModalOpen = false;
        this.dispatchEvent(new CustomEvent('update', {
            detail: {
                value: this.isModalOpen
            }
        }))
    }
}