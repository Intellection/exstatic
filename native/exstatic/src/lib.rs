use rustler::{Error, NifResult};
use statrs::distribution::{Continuous, ContinuousCDF, Normal};
use statrs::statistics::Distribution;

#[rustler::nif]
fn normal_pdf(mean: f64, std_dev: f64, x: f64) -> NifResult<f64> {
    let normal = Normal::new(mean, std_dev).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    Ok(normal.pdf(x))
}

#[rustler::nif]
fn normal_cdf(mean: f64, std_dev: f64, x: f64) -> NifResult<f64> {
    let normal = Normal::new(mean, std_dev).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    Ok(normal.cdf(x))
}

#[rustler::nif]
fn normal_entropy(std_dev: f64) -> NifResult<f64> {
    let normal = Normal::new(0.0, std_dev).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    normal
        .entropy()
        .ok_or_else(|| Error::Term(Box::new("Failed to calculate entropy")))
}

#[rustler::nif]
fn normal_variance(std_dev: f64) -> NifResult<f64> {
    let normal = Normal::new(0.0, std_dev).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    normal
        .variance()
        .ok_or_else(|| Error::Term(Box::new("Failed to calculate variance")))
}

#[rustler::nif]
fn normal_ln_pdf(mean: f64, std_dev: f64, x: f64) -> NifResult<f64> {
    let normal = Normal::new(mean, std_dev).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    Ok(normal.ln_pdf(x))
}

#[rustler::nif]
fn normal_sf(mean: f64, std_dev: f64, x: f64) -> NifResult<f64> {
    let normal = Normal::new(mean, std_dev).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    Ok(normal.sf(x))
}

#[rustler::nif]
fn normal_inverse_cdf(mean: f64, std_dev: f64, p: f64) -> NifResult<f64> {
    let normal = Normal::new(mean, std_dev).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    if !(0.0..=1.0).contains(&p) {
        return Err(Error::Term(Box::new("p must be in [0, 1]")));
    }
    Ok(normal.inverse_cdf(p))
}

rustler::init!("Elixir.Exstatic.Native");
