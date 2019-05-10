import { Component, OnInit, Input } from '@angular/core';
import { RestService } from '../rest.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-product-update',
  templateUrl: './product-update.component.html',
  styleUrls: ['./product-update.component.css']
})
export class ProductUpdateComponent implements OnInit {

  @Input() productData: any = { prod_name: '', prod_desc: '', prod_price: 0 };

  constructor(public rest: RestService, private route: ActivatedRoute, private router: Router) { }

  ngOnInit() {
    this.rest.getProduct(this.route.snapshot.params.id).subscribe((data: {}) => {
      console.log(data);
      this.productData = data;
    });
  }

  updateProduct() {
    this.rest.updateProduct(this.route.snapshot.params.id, this.productData).subscribe((result) => {
      this.router.navigate(['/product-info/' + this.route.snapshot.params.id]);
    }, (err) => {
      console.log(err);
    });
  }

}
