/**
 * Public enquiry API boundary.
 * Connect this module to a Supabase Edge Function or trusted API in the integration phase.
 * Never write directly to privileged tables from the browser.
 */
export async function submitEnquiry() {
  throw new Error('Enquiry submission is not configured yet.');
}
