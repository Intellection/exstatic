use rustler::{Error, NifResult};
use statrs::distribution::{Continuous, ContinuousCDF, Normal, StudentsT};
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

#[rustler::nif]
fn t_pdf(mean: f64, std_dev: f64, df: f64, x: f64) -> NifResult<f64> {
    let t = StudentsT::new(mean, std_dev, df).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    Ok(t.pdf(x))
}

#[rustler::nif]
fn t_cdf(mean: f64, std_dev: f64, df: f64, x: f64) -> NifResult<f64> {
    let t = StudentsT::new(mean, std_dev, df).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    Ok(t.cdf(x))
}

#[rustler::nif]
fn t_variance(std_dev: f64, df: f64) -> NifResult<f64> {
    if df <= 1.0 {
        return Err(Error::Term(Box::new("Variance is undefined for df ≤ 1")));
    } else if df > 1.0 && df <= 2.0 {
        return Err(Error::Term(Box::new("Variance is infinite for 1 < df ≤ 2")));
    }

    let t = StudentsT::new(0.0, std_dev, df).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    t.variance().ok_or_else(|| Error::Term(Box::new("Failed to calculate variance")))
}

#[rustler::nif]
fn t_inverse_cdf(mean: f64, std_dev: f64, df: f64, p: f64) -> NifResult<f64> {
    if !(0.0..=1.0).contains(&p) {
        return Err(Error::Term(Box::new("p must be in [0, 1]")));
    }
    let t = StudentsT::new(mean, std_dev, df).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    Ok(t.inverse_cdf(p))
}

#[rustler::nif]
fn t_ln_pdf(mean: f64, std_dev: f64, df: f64, x: f64) -> NifResult<f64> {
    let t = StudentsT::new(mean, std_dev, df).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    Ok(t.ln_pdf(x))
}

#[rustler::nif]
fn t_sf(mean: f64, std_dev: f64, df: f64, x: f64) -> NifResult<f64> {
    let t = StudentsT::new(mean, std_dev, df).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    Ok(t.sf(x))
}

rustler::init!("Elixir.Exstatic.Native");
