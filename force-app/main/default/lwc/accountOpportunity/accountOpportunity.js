import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import getOpportunities from '@salesforce/apex/AccountOpportunityController.getOpportunities';

import ACCOUNT_ID from '@salesforce/schema/Account.Id'

export default class AccountOpportunity extends NavigationMixin(LightningElement) {
    @api accid;
    @api recordId;
    @track accountOpportunity = [];
    timeout = null;
    isModalOpen = false;
    oppId;
    
    get opportunities() {
        if(this.accountOpportunity.length) {
            return this.accountOpportunity;
        } else {
            return null;
        }
    }
    get opportunityId() {
        return this.oppId;
    }

    @wire( getRecord, { recordId : '$recordId', fields : ACCOUNT_ID } )
    account({error, data}) {

        if(error) {
            console.log('ERROR: ', error);
        } else if(data) {
            if(this.recordId) {
                clearTimeout(this.timeout);
                this.timeout = setTimeout(() => {
                    this.hasOpportunityQuery();
                }, 0);
            } 
        }

    }

    async hasOpportunityQuery() {
        try {
            this.accountOpportunity = await getOpportunities( { accountId : this.recordId } );            
        } catch (error) {
            console.log('ERROR: ',error);
        }
    }

    async connectedCallback() {
        try {
            this.accountOpportunity = await getOpportunities( { accountId : this.accid } );            
        } catch (error) {
            console.log('ERROR: ',error);
        }
    }

    showOpportunityEvent(event) {
        const oppId = event.target.getAttribute('data-id');
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: oppId,
                actionName: 'view',
            },
        });
    }

    handleOpenModalPopup(event) {
        this.oppId = event.target.getAttribute('data-id');
        this.isModalOpen = true;
    }
    handleClosePopup(event) {
        this.isModalOpen = event.detail.value;
    }

}