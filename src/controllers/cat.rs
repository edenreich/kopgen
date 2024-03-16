use crate::{add_event, Cat};
use crate::{add_finalizer, remove_finalizer};
use kube::api::{Api, WatchEvent};
use kube::Resource;
use log::info;

pub async fn handle_cat(event: WatchEvent<Cat>, api: Api<Cat>) {
    match event {
        WatchEvent::Added(mut cat) => {
            if cat.metadata.deletion_timestamp.is_some() {
                info!(
                    "{} Sending API call to delete the remote resource and wait for response: {:?}",
                    "Cat", cat.metadata.name
                );
                remove_finalizer(&mut cat, api.clone()).await;
            } else {
                add_finalizer(&mut cat, api.clone()).await;
                add_event(Cat::kind(&()).to_string(), &mut cat, "Added".to_string()).await;
                info!(
                    "{} Added: {:?} {:?}",
                    "Cat", cat.metadata.name, cat.metadata.finalizers
                )
            }
        }
        WatchEvent::Modified(cat) => {
            info!(
                "{} Modified: {:?} {:?}",
                "Cat", cat.metadata.name, cat.metadata.finalizers
            );
        }
        WatchEvent::Deleted(cat) => {
            info!(
                "{} Deleted: {:?} {:?}",
                "Cat", cat.metadata.name, cat.metadata.finalizers
            );
        }
        WatchEvent::Bookmark(bookmark) => {
            info!(
                "{} Bookmark: {:?}",
                "Cat", bookmark.metadata.resource_version
            );
        }
        _ => {
            info!("{} Unknown event {:?}", "Cat", event);
        }
    }
}
